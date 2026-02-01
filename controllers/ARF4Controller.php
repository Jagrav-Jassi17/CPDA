<?php
session_start();
include_once '../config/db.php';

// Ensure user is Assistant Registrar
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'accounts_ar') {
    $_SESSION['error_message'] = "Unauthorized access.";
    header("Location: ../login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $application_id    = $_POST['application_id'] ?? null;
    $action            = $_POST['action'] ?? null;
    $ar_remarks        = $_POST['ar_remarks'] ?? '';
    $sanctioned_amount = floatval($_POST['sanctioned_amount'] ?? 0);
    $ar_code           = $_SESSION['employee_code'];

    if (!$application_id || !$action) {
        $_SESSION['error_message'] = "Invalid request parameters.";
        header("Location: ../views/accounts_ar_dashboard.php");
        exit();
    }

    if (empty($ar_remarks)) {
        $_SESSION['error_message'] = "Please provide remarks.";
        header("Location: ../views/ar_view_application.php?application_id={$application_id}&type=f5");
        exit();
    }

    try {
        $conn->begin_transaction();

        /* =====================================================
           1. LOCK & VERIFY F-5 APPLICATION
        ===================================================== */
        $stmt = $conn->prepare("
            SELECT 
                application_id,
                faculty_name,
                employee_code,
                hod_status,
                balance_applied
            FROM f5_conference_reimbursements
            WHERE application_id = ?
            FOR UPDATE
        ");
        $stmt->bind_param("i", $application_id);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows === 0) {
            throw new Exception("F-5 application not found.");
        }

        $app = $res->fetch_assoc();

        if ($app['hod_status'] !== 'APPROVED') {
            throw new Exception("Application must be HOD approved first.");
        }

        $facultyId = $app['employee_code'];

        /* =====================================================
           2. HANDLE APPROVE / REJECT
        ===================================================== */
        if ($action === 'approve') {

            if ((int)$app['balance_applied'] === 1) {
                throw new Exception("Balance already updated for this reimbursement.");
            }

            // 2A. Update F-5 status
            $stmt = $conn->prepare("
                UPDATE f5_conference_reimbursements
                SET 
                    accounts_status = 'APPROVED',
                    accounts_remarks = ?,
                    accounts_approved_by = ?,
                    accounts_approved_at = NOW(),
                    sanctioned_amount = ?,
                    last_updated = NOW()
                WHERE application_id = ?
            ");
            $stmt->bind_param("ssdi", $ar_remarks, $ar_code, $sanctioned_amount, $application_id);
            $stmt->execute();
            $stmt->close();

            /* =====================================================
               🔴 3. UPDATE ACTUAL CPDA BALANCE (CORE FIX)
            ===================================================== */
            // Ensure CPDA master row exists
            $stmt = $conn->prepare("
                INSERT INTO cpda_balance_master (faculty_id)
                VALUES (?)
                ON DUPLICATE KEY UPDATE faculty_id = faculty_id
            ");
            $stmt->bind_param("s", $facultyId);
            $stmt->execute();
            $stmt->close();

            // Deduct from actual balance
            $stmt = $conn->prepare("
                UPDATE cpda_balance_master
                SET utilized_amount = utilized_amount + ?
                WHERE faculty_id = ?
            ");
            $stmt->bind_param("ds", $sanctioned_amount, $facultyId);
            $stmt->execute();
            $stmt->close();

            // Lock reimbursement
            $stmt = $conn->prepare("
                UPDATE f5_conference_reimbursements
                SET balance_applied = 1
                WHERE application_id = ?
            ");
            $stmt->bind_param("i", $application_id);
            $stmt->execute();
            $stmt->close();

            $success_message = "F-5 reimbursement APPROVED. CPDA balance updated by ₹" .
                               number_format($sanctioned_amount, 2);

        } elseif ($action === 'reject') {

            // Reject → NO balance change
            $stmt = $conn->prepare("
                UPDATE f5_conference_reimbursements
                SET 
                    accounts_status = 'REJECTED',
                    accounts_remarks = ?,
                    accounts_approved_by = ?,
                    accounts_approved_at = NOW(),
                    sanctioned_amount = 0,
                    last_updated = NOW()
                WHERE application_id = ?
            ");
            $stmt->bind_param("ssi", $ar_remarks, $ar_code, $application_id);
            $stmt->execute();
            $stmt->close();

            $success_message = "F-5 reimbursement REJECTED.";
        } else {
            throw new Exception("Invalid action.");
        }

        /* =====================================================
           4. COMMIT
        ===================================================== */
        $conn->commit();

        $_SESSION['success_message'] = $success_message;
        header("Location: ../views/accounts_ar_dashboard.php");
        exit();

    } catch (Exception $e) {
        $conn->rollback();
        $_SESSION['error_message'] = "Error: " . $e->getMessage();
        header("Location: ../views/ar_view_application.php?application_id={$application_id}&type=f5");
        exit();
    }

} else {
    header("Location: ../views/accounts_ar_dashboard.php");
    exit();
}
?>

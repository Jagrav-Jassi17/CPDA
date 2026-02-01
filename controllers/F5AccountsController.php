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

    try {
        $conn->begin_transaction();

        $stmt = $conn->prepare("
            SELECT employee_code, hod_status, balance_applied
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

        if ($action === 'approve') {

            if ($app['balance_applied'] == 1) {
                throw new Exception("Balance already applied.");
            }

            $facultyId = $app['employee_code'];

            $stmt = $conn->prepare("
                UPDATE f5_conference_reimbursements
                SET accounts_status='APPROVED',
                    sanctioned_amount=?,
                    balance_applied=1,
                    accounts_approved_by=?,
                    accounts_approved_at=NOW()
                WHERE application_id=?
            ");
            $stmt->bind_param("dsi", $sanctioned_amount, $ar_code, $application_id);
            $stmt->execute();

            $stmt = $conn->prepare("
                INSERT INTO cpda_balance_master (faculty_id)
                VALUES (?)
                ON DUPLICATE KEY UPDATE faculty_id = faculty_id
            ");
            $stmt->bind_param("s", $facultyId);
            $stmt->execute();

            $stmt = $conn->prepare("
                UPDATE cpda_balance_master
                SET utilized_amount = utilized_amount + ?
                WHERE faculty_id = ?
            ");
            $stmt->bind_param("ds", $sanctioned_amount, $facultyId);
            $stmt->execute();
        }

        if ($action === 'reject') {
            $stmt = $conn->prepare("
                UPDATE f5_conference_reimbursements
                SET accounts_status='REJECTED',
                    accounts_approved_by=?,
                    accounts_approved_at=NOW()
                WHERE application_id=?
            ");
            $stmt->bind_param("si", $ar_code, $application_id);
            $stmt->execute();
        }

        $conn->commit();
        header("Location: ../views/accounts_ar_dashboard.php");
        exit();

    } catch (Exception $e) {
        $conn->rollback();
        die("F-5 approval failed: " . $e->getMessage());
    }
}

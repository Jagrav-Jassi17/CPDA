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
    
    $application_id = $_POST['application_id'] ?? null;
    $action = $_POST['action'] ?? null;
    $ar_remarks = $_POST['ar_remarks'] ?? '';
    $sanctioned_amount = floatval($_POST['sanctioned_amount'] ?? 0);
    $ar_code = $_SESSION['employee_code'];
    $ar_name = $_SESSION['name'];
    
    if (!$application_id || !$action) {
        $_SESSION['error_message'] = "Invalid request parameters.";
        header("Location: ../views/accounts_ar_dashboard.php");
        exit();
    }
    
    if (empty($ar_remarks)) {
        $_SESSION['error_message'] = "Please provide remarks.";
        header("Location: ../views/ar_view_application.php?application_id=" . $application_id . "&type=f4");
        exit();
    }
    
    try {
        $conn->begin_transaction();
        
        // Verify application exists
        $stmt_verify = $conn->prepare("
            SELECT application_id, faculty_name, hod_approval_status 
            FROM f4_reimbursement_applications 
            WHERE application_id = ?
        ");
        $stmt_verify->bind_param("i", $application_id);
        $stmt_verify->execute();
        $result = $stmt_verify->get_result();
        
        if ($result->num_rows === 0) {
            throw new Exception("Application not found.");
        }
        
        $app = $result->fetch_assoc();
        
        if ($app['hod_approval_status'] !== 'APPROVED') {
            throw new Exception("Application must be HOD approved first.");
        }
        
        $stmt_verify->close();
        
        // Determine final status
        if ($action === 'approve') {
            $ar_approval_status = 'APPROVED';
            $application_status = 'AR_APPROVED';
            $disbursement_status = 'PENDING';
            $success_message = "F-4 application for " . $app['faculty_name'] . " has been APPROVED. Sanctioned amount: ₹" . number_format($sanctioned_amount, 2);
        } elseif ($action === 'reject') {
            $ar_approval_status = 'REJECTED';
            $application_status = 'AR_REJECTED';
            $disbursement_status = 'PENDING';
            $sanctioned_amount = 0;
            $success_message = "F-4 application for " . $app['faculty_name'] . " has been REJECTED.";
        } else {
            throw new Exception("Invalid action.");
        }
        
        // Update application
        $stmt_update = $conn->prepare("
            UPDATE f4_reimbursement_applications 
            SET 
                ar_approval_status = ?,
                ar_approval_date = NOW(),
                ar_remarks = ?,
                ar_approved_by = ?,
                application_status = ?,
                sanctioned_amount = ?,
                disbursement_status = ?,
                last_updated = NOW()
            WHERE application_id = ?
        ");
        
        $stmt_update->bind_param(
            "ssssdsi",
            $ar_approval_status,
            $ar_remarks,
            $ar_code,
            $application_status,
            $sanctioned_amount,
            $disbursement_status,
            $application_id
        );
        
        if (!$stmt_update->execute()) {
            throw new Exception("Failed to update: " . $stmt_update->error);
        }
        
        $stmt_update->close();
        $conn->commit();
        
        $_SESSION['success_message'] = $success_message;
        header("Location: ../views/accounts_ar_dashboard.php");
        exit();
        
    } catch (Exception $e) {
        $conn->rollback();
        $_SESSION['error_message'] = "Error: " . $e->getMessage();
        header("Location: ../views/ar_view_application.php?application_id=" . $application_id . "&type=f4");
        exit();
    }
    
} else {
    header("Location: ../views/accounts_ar_dashboard.php");
    exit();
}
?>

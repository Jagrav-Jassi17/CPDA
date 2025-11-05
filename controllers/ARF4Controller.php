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
        header("Location: ../views/ar_view_application.php?application_id=" . $application_id . "&type=f5");
        exit();
    }
    
    try {
        $conn->begin_transaction();
        
        // Verify application exists
        $stmt_verify = $conn->prepare("
            SELECT application_id, faculty_name, hod_status, accounts_status 
            FROM f5_conference_reimbursements 
            WHERE application_id = ?
        ");
        $stmt_verify->bind_param("i", $application_id);
        $stmt_verify->execute();
        $result = $stmt_verify->get_result();
        
        if ($result->num_rows === 0) {
            throw new Exception("F-5 application not found.");
        }
        
        $app = $result->fetch_assoc();
        
        if ($app['hod_status'] !== 'APPROVED') {
            throw new Exception("Application must be HOD approved first.");
        }
        
        if ($app['accounts_status'] !== 'PENDING') {
            throw new Exception("Application has already been processed by accounts.");
        }
        
        $stmt_verify->close();
        
        // Determine final status
        if ($action === 'approve') {
            $accounts_status = 'APPROVED';
            $application_status = 'COMPLETED';
            $success_message = "F-5 conference application for " . $app['faculty_name'] . " has been APPROVED. Sanctioned amount: ₹" . number_format($sanctioned_amount, 2);
        } elseif ($action === 'reject') {
            $accounts_status = 'REJECTED';
            $application_status = 'ACCOUNTS_REJECTED';
            $sanctioned_amount = 0;
            $success_message = "F-5 conference application for " . $app['faculty_name'] . " has been REJECTED.";
        } else {
            throw new Exception("Invalid action.");
        }
        
        // Update application
        $stmt_update = $conn->prepare("
            UPDATE f5_conference_reimbursements 
            SET 
                accounts_status = ?,
                accounts_approved_by = ?,
                accounts_approved_at = NOW(),
                accounts_comments = ?,
                status = ?,
                updated_at = NOW()
            WHERE application_id = ?
        ");
        
        $stmt_update->bind_param(
            "ssssi",
            $accounts_status,
            $ar_code,
            $ar_remarks,
            $application_status,
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
        header("Location: ../views/ar_view_application.php?application_id=" . $application_id . "&type=f5");
        exit();
    }
    
} else {
    header("Location: ../views/accounts_ar_dashboard.php");
    exit();
}
?>

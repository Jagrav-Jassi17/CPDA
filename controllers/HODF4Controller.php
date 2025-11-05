<?php
session_start();
include_once '../config/db.php';

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Ensure user is HOD
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'hod') {
    $_SESSION['error_message'] = "Unauthorized access. Please login as HOD.";
    header("Location: ../login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    $application_id = $_POST['application_id'] ?? null;
    $action = $_POST['action'] ?? null;
    $hod_remarks = $_POST['hod_remarks'] ?? '';
    $hod_code = $_SESSION['employee_code'] ?? '';
    $hod_name = $_SESSION['name'] ?? '';
    
    // Debug: Log received data
    error_log("F5 Controller - Application ID: $application_id, Action: $action");
    
    if (!$application_id || !$action) {
        $_SESSION['error_message'] = "Invalid request parameters. Application ID or Action missing.";
        header("Location: ../views/hod_dashboard.php");
        exit();
    }
    
    if (empty($hod_remarks)) {
        $_SESSION['error_message'] = "Please provide remarks before submitting.";
        header("Location: ../views/hod_view_application.php?application_id=" . $application_id . "&type=f5");
        exit();
    }
    
    try {
        // Start transaction
        $conn->begin_transaction();
        
        // Verify the application exists and belongs to HOD's department
        $stmt_verify = $conn->prepare("
            SELECT application_id, department, faculty_name, status, hod_status 
            FROM f5_conference_reimbursements 
            WHERE application_id = ?
        ");
        
        if (!$stmt_verify) {
            throw new Exception("Prepare failed: " . $conn->error);
        }
        
        $stmt_verify->bind_param("i", $application_id);
        
        if (!$stmt_verify->execute()) {
            throw new Exception("Execute failed: " . $stmt_verify->error);
        }
        
        $result = $stmt_verify->get_result();
        
        if ($result->num_rows === 0) {
            throw new Exception("F-5 application not found with ID: $application_id");
        }
        
        $app = $result->fetch_assoc();
        
        // Debug: Log application details
        error_log("Current Status: " . $app['status']);
        error_log("Current HOD Status: " . $app['hod_status']);
        error_log("Department: " . $app['department'] . " vs Session: " . $_SESSION['department']);
        
        if ($app['department'] !== $_SESSION['department']) {
            throw new Exception("Unauthorized access. Application belongs to " . $app['department'] . " but you are HOD of " . $_SESSION['department']);
        }
        
        $stmt_verify->close();
        
        // Determine approval status based on action
        if ($action === 'approve') {
            $hod_status = 'APPROVED';
            $application_status = 'HOD_APPROVED';
            $success_message = "F-5 conference application for " . $app['faculty_name'] . " approved successfully.";
        } elseif ($action === 'reject') {
            $hod_status = 'REJECTED';
            $application_status = 'HOD_REJECTED';
            $success_message = "F-5 conference application for " . $app['faculty_name'] . " rejected.";
        } else {
            throw new Exception("Invalid action specified: $action");
        }
        
        // Debug: Log what we're about to update
        error_log("Updating to - HOD Status: $hod_status, App Status: $application_status");
        
        // Update the application with HOD decision
        $stmt_update = $conn->prepare("
            UPDATE f5_conference_reimbursements 
            SET 
                hod_status = ?,
                hod_approved_by = ?,
                hod_approved_at = NOW(),
                hod_comments = ?,
                status = ?,
                updated_at = NOW()
            WHERE application_id = ?
        ");
        
        if (!$stmt_update) {
            throw new Exception("Prepare update failed: " . $conn->error);
        }
        
        $stmt_update->bind_param(
            "ssssi",
            $hod_status,
            $hod_code,
            $hod_remarks,
            $application_status,
            $application_id
        );
        
        if (!$stmt_update->execute()) {
            throw new Exception("Failed to update F-5 application: " . $stmt_update->error);
        }
        
        $affected_rows = $stmt_update->affected_rows;
        error_log("Affected rows: $affected_rows");
        
        if ($affected_rows === 0) {
            throw new Exception("No rows were updated. Application ID might be invalid or already processed.");
        }
        
        $stmt_update->close();
        
        // Commit transaction
        $conn->commit();
        
        // Set success message
        $_SESSION['success_message'] = $success_message;
        error_log("Success: $success_message");
        
        header("Location: ../views/hod_dashboard.php");
        exit();
        
    } catch (Exception $e) {
        // Rollback on error
        if ($conn) {
            $conn->rollback();
        }
        
        $error_msg = "Error processing F-5 application: " . $e->getMessage();
        error_log($error_msg);
        
        $_SESSION['error_message'] = $error_msg;
        header("Location: ../views/hod_view_application.php?application_id=" . $application_id . "&type=f5");
        exit();
    }
    
} else {
    // Invalid request method
    $_SESSION['error_message'] = "Invalid request method.";
    header("Location: ../views/hod_dashboard.php");
    exit();
}
?>

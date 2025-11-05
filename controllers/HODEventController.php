<?php
session_start();
include_once '../config/db.php';

// Redirect if not HOD
if ($_SESSION['role'] !== 'hod') {
    header("Location: ../views/login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $application_id = intval($_POST['application_id']);
    $action = $_POST['action']; // 'approve' or 'reject'
    $hod_remarks = $conn->real_escape_string($_POST['hod_remarks']);
    $hod_employee_code = $_SESSION['employee_code'];
    
    try {
        $conn->begin_transaction();
        
        if ($action === 'approve') {
            // Update HOD approval status to APPROVED
            $sql = "UPDATE cpda_event_applications 
                    SET hod_approval_status = 'APPROVED',
                        hod_approval_date = NOW(),
                        hod_remarks = ?,
                        hod_approved_by = ?,
                        application_status = 'HOD_APPROVED',
                        last_updated = NOW()
                    WHERE application_id = ?";
            
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ssi", $hod_remarks, $hod_employee_code, $application_id);
            
        } elseif ($action === 'reject') {
            // Update HOD approval status to REJECTED
            $sql = "UPDATE cpda_event_applications 
                    SET hod_approval_status = 'REJECTED',
                        hod_approval_date = NOW(),
                        hod_remarks = ?,
                        hod_approved_by = ?,
                        application_status = 'HOD_REJECTED',
                        last_updated = NOW()
                    WHERE application_id = ?";
            
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ssi", $hod_remarks, $hod_employee_code, $application_id);
            
        } else {
            throw new Exception("Invalid action");
        }
        
        if (!$stmt->execute()) {
            throw new Exception("Database update failed: " . $stmt->error);
        }
        
        $conn->commit();
        
        $status_msg = ($action === 'approve') ? 'approved and forwarded to Dean' : 'rejected';
        $_SESSION['success_message'] = "Application has been successfully $status_msg.";
        header("Location: ../views/hod_dashboard.php");
        exit();
        
    } catch (Exception $e) {
        $conn->rollback();
        $_SESSION['error_message'] = "Error processing application: " . $e->getMessage();
        header("Location: ../views/hod_view_application.php?application_id=$application_id&type=event");
        exit();
    }
    
} else {
    header("Location: ../views/hod_dashboard.php");
    exit();
}
?>

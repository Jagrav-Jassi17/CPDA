<?php
session_start();
include_once '../config/db.php';

// Redirect if not HOD
if ($_SESSION['role'] !== 'hod') {
    header("Location: ../views/login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $app_id = intval($_POST['application_id']);
    $action = $_POST['action']; // 'recommend' or 'not_recommend'
    $comments = $conn->real_escape_string($_POST['comments'] ?? '');
    $hod_name = $conn->real_escape_string($_SESSION['name']);
    $hod_employee_code = $_SESSION['employee_code'];

    try {
        $conn->begin_transaction();

        if ($action === 'recommend') {
            $status = 'HOD_APPROVED';
            $stage = 'ACCOUNTS_REVIEW';
        } elseif ($action === 'not_recommend') {
            $status = 'HOD_REJECTED';
            $stage = 'COMPLETED';
        } else {
            throw new Exception("Invalid action");
        }

        // Update main application
        $stmt = $conn->prepare("UPDATE cpda_applications 
                                SET status = ?, 
                                    current_stage = ?, 
                                    updated_at = NOW() 
                                WHERE application_id = ?");
        $stmt->bind_param("ssi", $status, $stage, $app_id);
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to update application: " . $stmt->error);
        }

        // Insert into workflow tracking
        $stmt2 = $conn->prepare("INSERT INTO approval_workflow 
            (application_id, approver_role, approver_name, action, comments, action_date) 
            VALUES (?, 'HOD', ?, ?, ?, NOW())");
        $stmt2->bind_param("isss", $app_id, $hod_name, $action, $comments);
        
        if (!$stmt2->execute()) {
            throw new Exception("Failed to insert workflow record: " . $stmt2->error);
        }

        $conn->commit();
        
        $status_msg = ($action === 'recommend') ? 'recommended and forwarded to Accounts' : 'rejected';
        $_SESSION['success_message'] = "Application has been successfully $status_msg.";
        header("Location: ../views/hod_dashboard.php");
        exit();
        
    } catch (Exception $e) {
        $conn->rollback();
        $_SESSION['error_message'] = "Error processing application: " . $e->getMessage();
        header("Location: ../views/hod_view_application.php?id=$app_id&type=form1");
        exit();
    }
    
} else {
    header("Location: ../views/hod_dashboard.php");
    exit();
}
?>

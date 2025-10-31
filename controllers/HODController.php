<?php
session_start();
include_once '../config/db.php';

if ($_SESSION['role'] !== 'hod') {
    header("Location: ../views/login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $app_id = $_POST['application_id'];
    $action = $_POST['action'];
    $comments = $_POST['comments'] ?? '';
    $hod_name = $_SESSION['name'];

    if ($action === 'recommend') {
        $status = 'HOD_APPROVED';
        $stage = 'ACCOUNTS_REVIEW';
    } else {
        $status = 'HOD_REJECTED';
        $stage = 'COMPLETED';
    }

    // Update main application
    $stmt = $conn->prepare("UPDATE cpda_applications 
                            SET status = ?, current_stage = ?, updated_at = NOW() 
                            WHERE application_id = ?");
    $stmt->bind_param("ssi", $status, $stage, $app_id);
    $stmt->execute();

    // Insert into workflow tracking
    $stmt2 = $conn->prepare("INSERT INTO approval_workflow 
        (application_id, approver_role, approver_name, action, comments, action_date) 
        VALUES (?, 'HOD', ?, ?, ?, NOW())");
    $stmt2->bind_param("isss", $app_id, $hod_name, $action, $comments);
    $stmt2->execute();

    header("Location: ../views/hod_dashboard.php?msg=Action recorded successfully");
    exit();
}
?>

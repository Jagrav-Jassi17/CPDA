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

    error_log("F4 Controller - Application ID: $application_id, Action: $action");

    if (!$application_id || !$action) {
        $_SESSION['error_message'] = "Invalid request parameters. Application ID or Action missing.";
        header("Location: ../views/hod_dashboard.php");
        exit();
    }

    if (empty($hod_remarks)) {
        $_SESSION['error_message'] = "Please provide remarks before submitting.";
        header("Location: ../views/hod_view_application.php?application_id=" . $application_id . "&type=f4");
        exit();
    }

    try {
        $conn->begin_transaction();

        // Verify the application exists and belongs to HOD's department
        $stmt_verify = $conn->prepare("
            SELECT application_id, department, faculty_name, application_status, hod_approval_status, ref_number
            FROM f4_reimbursement_applications 
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
            throw new Exception("Application not found with ID: $application_id");
        }

        $app = $result->fetch_assoc();

        error_log("Current Status: " . $app['application_status']);
        error_log("Current HOD Status: " . $app['hod_approval_status']);
        error_log("Department: " . $app['department'] . " vs Session: " . $_SESSION['department']);

        if ($app['department'] !== $_SESSION['department']) {
            throw new Exception("Unauthorized access. Application belongs to " . $app['department'] . " but you are HOD of " . $_SESSION['department']);
        }

        $stmt_verify->close();

        // Determine approval status based on action
        if ($action === 'approve') {
            $hod_approval_status = 'APPROVED';
            $application_status = 'HOD_APPROVED';
            $success_message = "F-4 application for " . $app['faculty_name'] . " approved successfully.";
            $message_prefix = "[APPROVED]";
            $stage = 'AR_REVIEW';
        } elseif ($action === 'reject') {
            $hod_approval_status = 'REJECTED';
            $application_status = 'HOD_REJECTED';
            $success_message = "F-4 application for " . $app['faculty_name'] . " rejected.";
            $message_prefix = "[REJECTED]";
            $stage = 'COMPLETED';
        } else {
            throw new Exception("Invalid action specified: $action");
        }

        error_log("Updating to - HOD Status: $hod_approval_status, App Status: $application_status");

        // Update the application with HOD decision
        $stmt_update = $conn->prepare("
            UPDATE f4_reimbursement_applications 
            SET 
                hod_approval_status = ?,
                hod_approval_date = NOW(),
                hod_remarks = ?,
                hod_approved_by = ?,
                application_status = ?,
                last_updated = NOW()
            WHERE application_id = ?
        ");

        if (!$stmt_update) {
            throw new Exception("Prepare update failed: " . $conn->error);
        }

        $stmt_update->bind_param(
            "ssssi",
            $hod_approval_status,
            $hod_remarks,
            $hod_code,
            $application_status,
            $application_id
        );

        if (!$stmt_update->execute()) {
            throw new Exception("Failed to update application: " . $stmt_update->error);
        }

        $affected_rows = $stmt_update->affected_rows;
        error_log("Affected rows: $affected_rows");

        if ($affected_rows === 0) {
            throw new Exception("No rows were updated. Application ID might be invalid.");
        }

        $stmt_update->close();

        // Determine next role from stage
        $stage_role_map = [
            'AR_REVIEW' => 'accounts_ar',
            'RETURN' => 'faculty',
        ];

        $next_role = $stage_role_map[$stage] ?? null;
        $recipient_employee_code = $app['employee_code'];

        if ($next_role) {
            $stmt_user = $conn->prepare("SELECT employee_code FROM users WHERE role = ? LIMIT 1");
            $stmt_user->bind_param("s", $next_role);
            $stmt_user->execute();
            $result_user = $stmt_user->get_result();
            if ($result_user->num_rows > 0) {
                $user_row = $result_user->fetch_assoc();
                $recipient_employee_code = $user_row['employee_code'];
            }
            $stmt_user->close();
        }

        // Determine next message sequence
        $ref_number = $app['ref_number'];
        $stmt_seq = $conn->prepare("SELECT IFNULL(MAX(message_sequence), 0) + 1 AS next_seq FROM application_timeline_messages WHERE ref_number = ?");
        $stmt_seq->bind_param("s", $ref_number);
        $stmt_seq->execute();
        $res_seq = $stmt_seq->get_result();
        $seq_row = $res_seq->fetch_assoc();
        $next_seq = $seq_row['next_seq'];
        $stmt_seq->close();

        $full_message = $message_prefix . " " . $hod_remarks;

        $stmt_msg = $conn->prepare("INSERT INTO application_timeline_messages (ref_number, message_sequence, message, sender_identifier, recipient_identifier, message_time) VALUES (?, ?, ?, ?, ?, NOW())");
        $stmt_msg->bind_param("sissi", $ref_number, $next_seq, $full_message, $hod_code, $recipient_employee_code);

        if (!$stmt_msg->execute()) {
            throw new Exception("Failed to insert timeline message: " . $stmt_msg->error);
        }

        $stmt_msg->close();

        // Commit transaction
        $conn->commit();

        $_SESSION['success_message'] = $success_message;
        error_log("Success: $success_message");

        header("Location: ../views/hod_dashboard.php");
        exit();

    } catch (Exception $e) {
        // Rollback on error
        if ($conn) {
            $conn->rollback();
        }
        $error_msg = "Error processing application: " . $e->getMessage();
        error_log($error_msg);
        $_SESSION['error_message'] = $error_msg;
        header("Location: ../views/hod_view_application.php?application_id=" . $application_id . "&type=f4");
        exit();
    }

} else {
    $_SESSION['error_message'] = "Invalid request method.";
    header("Location: ../views/hod_dashboard.php");
    exit();
}

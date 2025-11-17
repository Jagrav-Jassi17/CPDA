<?php
session_start();
include_once '../config/db.php';

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
            $stage = 'DA_REVIEW';
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
        $stmt->close();

        // Get ref_number for this application
        $stmt_ref = $conn->prepare("SELECT ref_number FROM cpda_applications WHERE application_id = ?");
        $stmt_ref->bind_param("i", $app_id);
        $stmt_ref->execute();
        $result_ref = $stmt_ref->get_result();
        if ($result_ref->num_rows === 0) {
            throw new Exception("Reference number not found.");
        }
        $row_ref = $result_ref->fetch_assoc();
        $ref_number = $row_ref['ref_number'];
        $stmt_ref->close();

        // Find next recipient employee code from users table based on next stage
        // Map stage to role, adjust as per your design
        $stage_role_map = [
            'DA_REVIEW' => 'dfw_da',
            'RETURN' => 'faculty',
            // add more mappings if needed
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

        // Determine next message sequence number
        $stmt_seq = $conn->prepare("SELECT IFNULL(MAX(message_sequence), 0) + 1 AS next_seq FROM application_timeline_messages WHERE ref_number = ?");
        $stmt_seq->bind_param("s", $ref_number);
        $stmt_seq->execute();
        $result_seq = $stmt_seq->get_result();
        $seq_row = $result_seq->fetch_assoc();
        $next_seq = $seq_row['next_seq'];
        $stmt_seq->close();

        // Compose message to insert
        $message_prefix = $action === 'recommend' ? "[APPROVED]" : "[REJECTED]";
        $full_message = $message_prefix . " " . $comments;

        // Insert into application timeline
        $stmt_msg = $conn->prepare("INSERT INTO application_timeline_messages (ref_number, message_sequence, message, sender_identifier, recipient_identifier, message_time) VALUES (?, ?, ?, ?, ?, NOW())");
        $stmt_msg->bind_param("sissi", $ref_number, $next_seq, $full_message, $hod_employee_code, $recipient_employee_code);
        if (!$stmt_msg->execute()) {
            throw new Exception("Failed to insert timeline message: " . $stmt_msg->error);
        }
        $stmt_msg->close();

        $conn->commit();

        $status_msg = ($action === 'recommend') ? 'recommended and forwarded' : 'rejected';
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

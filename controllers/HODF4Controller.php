<?php
session_start();
include_once '../config/db.php';

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
        $conn->begin_transaction();

        // FIXED: Added ref_number + department
        $stmt_verify = $conn->prepare("
            SELECT application_id, department, faculty_name, status, hod_status, ref_number
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
        $stmt_verify->close();

        if ($app['department'] !== $_SESSION['department']) {
            throw new Exception(
                "Unauthorized. Application belongs to {$app['department']} but you are HOD of {$_SESSION['department']}"
            );
        }

        // ACTION HANDLING
        if ($action === 'approve') {
            $hod_status = 'APPROVED';
            $application_status = 'HOD_APPROVED';
            $success_message = "F-5 application for {$app['faculty_name']} approved.";
            $message_prefix = "[APPROVED]";
            $stage = 'AR_REVIEW';
        } elseif ($action === 'reject') {
            $hod_status = 'REJECTED';
            $application_status = 'HOD_REJECTED';
            $success_message = "F-5 application for {$app['faculty_name']} rejected.";
            $message_prefix = "[REJECTED]";
            $stage = 'COMPLETED';
        } else {
            throw new Exception("Invalid action specified: $action");
        }

        // UPDATE APPLICATION
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

        if ($stmt_update->affected_rows === 0) {
            throw new Exception("No rows updated. Application ID invalid or already processed.");
        }

        $stmt_update->close();

        // NEXT ROLE MAP FIXED
        $stage_role_map = [
            'AR_REVIEW' => 'accounts_ar',
            'RETURN' => 'faculty',
        ];

        $next_role = $stage_role_map[$stage] ?? null;
        $recipient_employee_code = $app['employee_code'];

        if ($next_role) {
            $stmt_user = $conn->prepare("SELECT employee_code FROM users WHERE role = ? LIMIT 1");
            if (!$stmt_user) {
                throw new Exception("User role query failed: " . $conn->error);
            }

            $stmt_user->bind_param("s", $next_role);
            $stmt_user->execute();
            $result_user = $stmt_user->get_result();

            if ($result_user->num_rows > 0) {
                $recipient_employee_code = $result_user->fetch_assoc()['employee_code'];
            }

            $stmt_user->close();
        }

        // TIMELINE INSERT FIX – ref_number now available
        $ref_number = $app['ref_number'];

        $stmt_seq = $conn->prepare("
            SELECT IFNULL(MAX(message_sequence), 0) + 1 AS next_seq
            FROM application_timeline_messages
            WHERE ref_number = ?
        ");
        $stmt_seq->bind_param("s", $ref_number);
        $stmt_seq->execute();
        $next_seq = $stmt_seq->get_result()->fetch_assoc()['next_seq'];
        $stmt_seq->close();

        $full_message = $message_prefix . " " . $hod_remarks;

        $stmt_msg = $conn->prepare("
            INSERT INTO application_timeline_messages
            (ref_number, message_sequence, message, sender_identifier, recipient_identifier, message_time)
            VALUES (?, ?, ?, ?, ?, NOW())
        ");

        if (!$stmt_msg) {
            throw new Exception("Timeline insert prepare failed: " . $conn->error);
        }

        $stmt_msg->bind_param(
            "sissi",
            $ref_number,
            $next_seq,
            $full_message,
            $hod_code,
            $recipient_employee_code
        );

        if (!$stmt_msg->execute()) {
            throw new Exception("Timeline insert failed: " . $stmt_msg->error);
        }

        $stmt_msg->close();

        $conn->commit();

        $_SESSION['success_message'] = $success_message;
        header("Location: ../views/hod_dashboard.php");
        exit();

    } catch (Exception $e) {

        if ($conn) {
            $conn->rollback();
        }

        $_SESSION['error_message'] = "Error processing F-5 application: " . $e->getMessage();
        header("Location: ../views/hod_view_application.php?application_id=" . $application_id . "&type=f5");
        exit();
    }

} else {
    $_SESSION['error_message'] = "Invalid request method.";
    header("Location: ../views/hod_dashboard.php");
    exit();
}
?>

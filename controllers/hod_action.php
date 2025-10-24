<?php
include_once '../config/db.php';
session_start();

if ($_SESSION['role'] != 'hod') {
    die("Unauthorized access");
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $form_id = $_POST['form_id'];
    $hod_remark = $_POST['hod_remark'];
    $action = $_POST['action'];

    if ($action == 'recommend') {
        $new_status = 'accounts_review';
    } else {
        $new_status = 'rejected';
    }

    $sql = "UPDATE cpda_pda_form
            SET hod_remark = ?, status = ?
            WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssi", $hod_remark, $new_status, $form_id);

    if ($stmt->execute()) {
        echo "<script>alert('Action recorded successfully!'); window.location.href='../views/hod_dashboard.php';</script>";
    } else {
        echo "Error: " . $stmt->error;
    }
}
?>

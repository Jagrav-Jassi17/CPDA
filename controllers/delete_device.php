<?php
session_start();
include_once '../config/db.php';

if ($_SESSION['role'] !== 'accounts_ar') {
    http_response_code(403);
    exit("Unauthorized");
}

$id = $_POST['id'] ?? 0;

$stmt = $conn->prepare("DELETE FROM fdx_electronic_devices WHERE Device_ID = ?");
$stmt->bind_param("i", $id);
exit($stmt->execute() ? "Device deleted successfully" : "Delete failed: " . $stmt->error);

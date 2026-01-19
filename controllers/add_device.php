<?php
session_start();
include_once '../config/db.php';

if ($_SESSION['role'] !== 'accounts_ar') {
    http_response_code(403);
    exit("Unauthorized");
}

$emp  = $_POST['employee_code'] ?? '';
$item = $_POST['item'] ?? '';
$date = $_POST['date'] ?? '';
$cost = $_POST['cost'] ?? 0;

// Prevent duplicate device for same employee
$stmt = $conn->prepare("
    SELECT COUNT(*) AS cnt
    FROM fdx_electronic_devices
    WHERE employee_code = ? AND Item_Description = ? AND Date_of_Issue = ? AND Cost_at_Time_of_Issue = ?
");
$stmt->bind_param("sssd", $emp, $item, $date, $cost);
$stmt->execute();
$result = $stmt->get_result()->fetch_assoc();
if ($result['cnt'] > 0) {
    exit("This device is already added for this employee");
}

// Insert new device
$stmt = $conn->prepare("
    INSERT INTO fdx_electronic_devices (employee_code, Item_Description, Date_of_Issue, Cost_at_Time_of_Issue)
    VALUES (?, ?, ?, ?)
");
$stmt->bind_param("sssd", $emp, $item, $date, $cost);
echo $stmt->execute() ? "Device added successfully" : "Insert failed: " . $stmt->error;

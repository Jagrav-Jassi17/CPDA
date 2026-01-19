<?php
session_start();
include_once '../config/db.php';

if ($_SESSION['role'] !== 'accounts_ar') {
    http_response_code(403);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

$id = $data['id'] ?? 0;
$fields = $data['fields'] ?? [];

$allowed = ['Item_Description', 'Date_of_Issue', 'Cost_at_Time_of_Issue'];

$set = [];
$values = [];
$types = '';

foreach ($fields as $col => $val) {
    if (!in_array($col, $allowed)) continue;
    $set[] = "$col = ?";
    $values[] = $val;
    $types .= is_numeric($val) ? 'd' : 's';
}

if (!$set) exit;

$values[] = $id;
$types .= 'i';

$sql = "UPDATE fdx_electronic_devices SET " . implode(',', $set) . " WHERE Device_ID = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param($types, ...$values);
$stmt->execute();

<?php
session_start();
include_once '../config/db.php';

$ref_number = $_GET['ref_number'] ?? '';
if (empty($ref_number)) {
    die("Reference number missing.");
}


// Fetch approval timeline data for this ref_number
$stmt = $conn->prepare("SELECT message_sequence, sender_identifier, recipient_identifier, message_time FROM application_timeline_messages WHERE ref_number = ? ORDER BY message_sequence ASC");
$stmt->bind_param("s", $ref_number);
$stmt->execute();
$result = $stmt->get_result();
$flow = [];
while ($row = $result->fetch_assoc()) {
    $flow[] = $row;
}
$stmt->close();

// Fetch unique user info for sender and recipient
$user_ids = [];
foreach ($flow as $step) {
    $user_ids[] = $step['sender_identifier'];
    if (!empty($step['recipient_identifier'])) {
        $user_ids[] = $step['recipient_identifier'];
    }
}
$user_ids = array_unique(array_filter($user_ids));
$users = [];
if (!empty($user_ids)) {
    $placeholders = implode(',', array_fill(0, count($user_ids), '?'));
    $types = str_repeat('s', count($user_ids));
    $stmt_user = $conn->prepare("SELECT employee_code, name, role FROM users WHERE employee_code IN ($placeholders)");
    $stmt_user->bind_param($types, ...$user_ids);
    $stmt_user->execute();
    $res_users = $stmt_user->get_result();
    while ($u = $res_users->fetch_assoc()) {
        $users[$u['employee_code']] = $u;
    }
    $stmt_user->close();
}

function userLabel($code, $users) {
    if (isset($users[$code])) {
        return htmlspecialchars($users[$code]['name'] . " (" . $users[$code]['role'] . ")");
    }
    return htmlspecialchars($code);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Application Flow for <?= htmlspecialchars($ref_number) ?></title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
        body { font-family: Arial, sans-serif; margin: 20px; }
    </style>
</head>
<body>
    
    <p><a href="faculty_dashboard.php" class="btn-back">⬅ Back to Dashboard</a></p>
    <h1>Application Approval Flow</h1>
    <h3>Reference Number: <?= htmlspecialchars($ref_number) ?></h3>

    <?php if (count($flow) === 0): ?>
        <p>No approval flow found for this application.</p>
    <?php else: ?>
        <table>
            <thead>
                <tr>
                    <th>Step</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Date & Time</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($flow as $step): ?>
                <tr>
                    <td><?= $step['message_sequence'] ?></td>
                    <td><?= userLabel($step['sender_identifier'], $users) ?></td>
                    <td><?= $step['recipient_identifier'] ? userLabel($step['recipient_identifier'], $users) : '<em>–</em>' ?></td>
                    <td><?= $step['message_time'] ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>

    <p><a href="faculty_application_history.php">⬅ Back to Application History</a></p>
</body>
</html>

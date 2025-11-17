<?php
session_start();
include_once '../config/db.php';

// Ensure user is logged in as faculty
if (!isset($_SESSION['employee_code'])) {
    header("Location: ../views/login.php");
    exit();
}
$employee_code = $_SESSION['employee_code'];

// Fetch faculty applications
$stmt = $conn->prepare("SELECT ref_number, application_id, current_stage, status, created_at FROM cpda_applications WHERE employee_code = ? ORDER BY created_at DESC");
$stmt->bind_param("s", $employee_code);
$stmt->execute();
$result = $stmt->get_result();
$applications = [];
while ($row = $result->fetch_assoc()) {
    $applications[] = $row;
}
$stmt->close();

$stmt2 = $conn->prepare("SELECT ref_number, application_id, current_stage, application_status, created_at FROM cpda_event_applications WHERE employee_code = ? ORDER BY created_at DESC");
$stmt2->bind_param("s", $employee_code);
$stmt2->execute();
$result2 = $stmt2->get_result();
$applications2 = [];
while ($row = $result2->fetch_assoc()) {
    $applications2[] = $row;
}
$stmt2->close();

$stmt3 = $conn->prepare("SELECT ref_number, application_id, application_status, created_at FROM f4_reimbursement_applications WHERE employee_code = ? ORDER BY created_at DESC");
$stmt3->bind_param("s", $employee_code);
$stmt3->execute();
$result3 = $stmt3->get_result();
$applications3 = [];
while ($row = $result3->fetch_assoc()) {
    $applications3[] = $row;
}
$stmt3->close();

$stmt4 = $conn->prepare("SELECT ref_number, application_id, status, created_at FROM f5_conference_reimbursements WHERE employee_code = ? ORDER BY created_at DESC");
$stmt4->bind_param("s", $employee_code);
$stmt4->execute();
$result4 = $stmt4->get_result();
$applications4 = [];
while ($row = $result4->fetch_assoc()) {
    $applications4[] = $row;
}
$stmt4->close();

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title> Applications</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
        a { color: #007bff; text-decoration:none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    
    <p><a href="faculty_dashboard.php" class="btn-back">⬅ Back to Dashboard</a></p>
    <h1>Your CPDA Applications</h1>
    <table>
        <thead>
            <tr>
                <th>Reference Number</th>
                <th>Status</th>
                <th>Submitted Date</th>
                <th>View Details</th>
            </tr>
        </thead>
        <tbody>
            <?php if (count($applications) === 0): ?>
                <tr><td colspan="5">No applications found.</td></tr>
            <?php else: ?>
                <?php foreach ($applications as $app): ?>
                <tr>
                    <td><?= htmlspecialchars($app['ref_number']) ?></td>
                    <td><?= htmlspecialchars($app['status']) ?></td>
                    <td><?= htmlspecialchars($app['created_at']) ?></td>
                    <td><a href="faculty_view_application_flow.php?ref_number=<?= urlencode($app['ref_number']) ?>">View Details</a></td>
                </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
    <h1>Your CPDA Events</h1>
    <table>
        <thead>
            <tr>
                <th>Reference Number</th>
                <th>Status</th>
                <th>Submitted Date</th>
                <th>View Details</th>
            </tr>
        </thead>
        <tbody>
            <?php if (count($applications2) === 0): ?>
                <tr><td colspan="5">No applications found.</td></tr>
            <?php else: ?>
                <?php foreach ($applications2 as $app): ?>
                <tr>
                    <td><?= htmlspecialchars($app['ref_number']) ?></td>
                    <td><?= htmlspecialchars($app['application_status']) ?></td>
                    <td><?= htmlspecialchars($app['created_at']) ?></td>
                    <td><a href="faculty_view_application_flow.php?ref_number=<?= urlencode($app['ref_number']) ?>">View Details</a></td>
                </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
    <h1>Reimbursement CPDA Applications</h1>
    <table>
        <thead>
            <tr>
                <th>Reference Number</th>
                <th>Status</th>
                <th>Submitted Date</th>
                <th>View Details</th>
            </tr>
        </thead>
        <tbody>
            <?php if (count($applications) === 0): ?>
                <tr><td colspan="5">No applications found.</td></tr>
            <?php else: ?>
                <?php foreach ($applications3 as $app): ?>
                <tr>
                    <td><?= htmlspecialchars($app['ref_number']) ?></td>
                    <td><?= htmlspecialchars($app['application_status']) ?></td>
                    <td><?= htmlspecialchars($app['created_at']) ?></td>
                    <td><a href="faculty_view_application_flow.php?ref_number=<?= urlencode($app['ref_number']) ?>">View Details</a></td>
                </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
    <h1>Reimbursement CPDA Events</h1>
    <table>
        <thead>
            <tr>
                <th>Reference Number</th>
                <th>Status</th>
                <th>Submitted Date</th>
                <th>View Details</th>
            </tr>
        </thead>
        <tbody>
            <?php if (count($applications) === 0): ?>
                <tr><td colspan="5">No applications found.</td></tr>
            <?php else: ?>
                <?php foreach ($applications4 as $app): ?>
                <tr>
                    <td><?= htmlspecialchars($app['ref_number']) ?></td>
                    <td><?= htmlspecialchars($app['status']) ?></td>
                    <td><?= htmlspecialchars($app['created_at']) ?></td>
                    <td><a href="faculty_view_application_flow.php?ref_number=<?= urlencode($app['ref_number']) ?>">View Details</a></td>
                </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</body>
</html>

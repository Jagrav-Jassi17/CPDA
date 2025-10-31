<?php
session_start();
include_once '../config/db.php';

// Redirect if not HOD
if ($_SESSION['role'] !== 'hod') {
    header("Location: login.php");
    exit();
}

$department = $_SESSION['department'];
$sql = "SELECT * FROM cpda_applications 
        WHERE department = ? 
          AND current_stage = 'HOD_REVIEW'
        ORDER BY created_at DESC";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $department);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HOD Dashboard</title>
</head>
<body>
    <h2>Welcome, <?= htmlspecialchars($_SESSION['name']); ?> (HOD - <?= htmlspecialchars($department); ?>)</h2>
    <h3>Pending Faculty Applications</h3>

    <table border="1" cellpadding="8">
        <tr>
            <th>Ref No</th>
            <th>Faculty Name</th>
            <th>Purpose</th>
            <th>Date Submitted</th>
            <th>Action</th>
        </tr>
        <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= htmlspecialchars($row['ref_number']); ?></td>
                <td><?= htmlspecialchars($row['faculty_name']); ?></td>
                <td><?= htmlspecialchars(substr($row['purpose_of_purchase'], 0, 50)); ?>...</td>
                <td><?= htmlspecialchars($row['created_at']); ?></td>
                <td>
                    <a href="hod_view_application.php?id=<?= $row['application_id']; ?>">View</a>
                </td>
            </tr>
        <?php endwhile; ?>
    </table>
</body>
</html>

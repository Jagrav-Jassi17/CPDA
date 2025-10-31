<?php
session_start();
if (!isset($_SESSION['employee_code'])) {
    header("Location: login.php");
    exit();
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Faculty Dashboard</title>
</head>
<body>
    <h2>Welcome, <?= htmlspecialchars($_SESSION['name']); ?> (<?= htmlspecialchars($_SESSION['role']); ?>)</h2>
    <p>Employee Code: <?= htmlspecialchars($_SESSION['employee_code']); ?></p>
    <p>Department: <?= htmlspecialchars($_SESSION['department']); ?></p>
    <p>Email: <?= htmlspecialchars($_SESSION['email']); ?></p>
    <a href="form1_faculty.php">➕ New CPDA Application (Form 1)</a>

    <a href="../controllers/logout.php">Logout</a>
</body>
</html>

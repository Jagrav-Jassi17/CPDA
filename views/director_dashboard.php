<?php
session_start();
if (!isset($_SESSION['employee_code'])) {
    header("Location: login.php");
    exit();
}
?>
<h2>Welcome <?= $_SESSION['name']; ?>!</h2>
<p>Role: <?= htmlspecialchars($_SESSION['role']); ?></p>
<a href="../controllers/logout.php">Logout</a>

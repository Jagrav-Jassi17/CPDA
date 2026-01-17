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

    <hr>

    <a href="form1_faculty.php">➕ CPDA Purchase & Membership Applications (Form 1)</a><br/>
    <a href="form2_faculty.php">➕ CPDA Event Participation Applications (Form 2)</a><br/>
    <a href="form3_faculty.php">➕ Reimbursement Purchase & Membership Applications (Form 3)</a><br/>
    <a href="form4_faculty.php">➕ Reimbursement Event Participation Applications (Form 4)</a><br/>

    <br>
    <hr>

    <a href="faculty_balance.php">📊 View CPDA Balance</a><br/>
    <a href="faculty_application_history.php">📄 Application History</a><br/>
    
    <a href="balance_database.php?employee_code=<?= urlencode($_SESSION['employee_code']); ?>" target="_blank">💰 Balance Chart</a><br/>
    
    <a href="../controllers/logout.php">Logout</a>
</body>
</html>
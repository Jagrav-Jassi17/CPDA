<?php
session_start();
include_once '../config/db.php';

if (!in_array($_SESSION['role'], ['accounts_da','accounts_supp','accounts_ar'])) {
    header("Location: ../views/login.php"); exit();
}

// Show applications which have arrived to accounts.
// You can filter by department if desired; for now show all in ACCOUNTS_REVIEW.
$sql = "SELECT application_id, ref_number, employee_code, faculty_name, department, created_at
        FROM cpda_applications
        WHERE current_stage = 'ACCOUNTS_REVIEW'
        ORDER BY created_at DESC";
$res = $conn->query($sql);
?>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8"><title>Accounts DA Dashboard</title></head>
<body>
<h2>Accounts - Pending Expenditure Entries</h2>
<p>Logged in as: <?= htmlspecialchars($_SESSION['name']) ?> (<?= htmlspecialchars($_SESSION['role']) ?>)</p>
<table border="1" cellpadding="6" cellspacing="0">
    <tr>
        <th>Ref No</th><th>Application ID</th><th>Employee</th><th>Dept</th><th>Submitted On</th><th>Action</th>
    </tr>
    <?php while($row = $res->fetch_assoc()): ?>
    <tr>
        <td><?= htmlspecialchars($row['ref_number']) ?></td>
        <td><?= $row['application_id'] ?></td>
        <td><?= htmlspecialchars($row['faculty_name']) ?> (<?= htmlspecialchars($row['employee_code']) ?>)</td>
        <td><?= htmlspecialchars($row['department']) ?></td>
        <td><?= htmlspecialchars($row['created_at']) ?></td>
        <td>
            <a href="accounts_expenditure_entry.php?application_id=<?= $row['application_id'] ?>">Enter Expenditure</a>
        </td>
    </tr>
    <?php endwhile; ?>
</table>
</body>
</html>

<?php
session_start();
include_once '../config/db.php';

// Redirect if not HOD
if ($_SESSION['role'] !== 'hod') {
    header("Location: login.php");
    exit();
}

$app_id = $_GET['id'] ?? null;
if (!$app_id) die("Invalid application ID.");

// Fetch main application details
$stmt = $conn->prepare("SELECT * FROM cpda_applications WHERE application_id = ?");
$stmt->bind_param("i", $app_id);
$stmt->execute();
$app = $stmt->get_result()->fetch_assoc();

// Fetch professional memberships
$stmt2 = $conn->prepare("SELECT * FROM professional_memberships WHERE application_id = ?");
$stmt2->bind_param("i", $app_id);
$stmt2->execute();
$memberships = $stmt2->get_result();

// Fetch consumable items
$stmt3 = $conn->prepare("SELECT * FROM consumable_items WHERE application_id = ?");
$stmt3->bind_param("i", $app_id);
$stmt3->execute();
$items = $stmt3->get_result();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HOD Review Application</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        h2, h3 { color: #333; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 25px; }
        table, th, td { border: 1px solid #ccc; }
        th, td { padding: 8px; text-align: left; }
        .section { background: #f7f7f7; padding: 10px; font-weight: bold; }
        textarea { width: 100%; }
        button { padding: 8px 15px; margin: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <h2>Application Review – HOD View</h2>

    <div class="section">Applicant Details</div>
    <table>
        <tr><th>Employee Code</th><td><?= htmlspecialchars($app['employee_code']); ?></td></tr>
        <tr><th>Name</th><td><?= htmlspecialchars($app['faculty_name']); ?></td></tr>
        <tr><th>Email</th><td><?= htmlspecialchars($app['email']); ?></td></tr>
        <tr><th>Mobile</th><td><?= htmlspecialchars($app['mobile_number']); ?></td></tr>
        <tr><th>Designation</th><td><?= htmlspecialchars($app['designation']); ?></td></tr>
        <tr><th>Department</th><td><?= htmlspecialchars($app['department']); ?></td></tr>
        <tr><th>Pay Level</th><td><?= htmlspecialchars($app['pay_level']); ?></td></tr>
        <tr><th>Date of Joining</th><td><?= htmlspecialchars($app['date_of_joining']); ?></td></tr>
        <tr><th>PDA Block</th><td><?= htmlspecialchars($app['pda_block_start_year']); ?> – <?= htmlspecialchars($app['pda_block_end_year']); ?></td></tr>
    </table>

    <div class="section">Purchase Details</div>
    <table>
        <tr><th>Purpose of Purchase</th><td><?= nl2br(htmlspecialchars($app['purpose_of_purchase'])); ?></td></tr>
        <tr><th>Technical Specification / Source</th><td><?= nl2br(htmlspecialchars($app['technical_specification'])); ?></td></tr>
        <tr><th>Remarks</th><td><?= nl2br(htmlspecialchars($app['remarks'])); ?></td></tr>
    </table>

    <div class="section">Professional Memberships</div>
    <table>
        <tr><th>Name of Professional Body</th><th>Amount</th><th>Type</th></tr>
        <?php if ($memberships->num_rows > 0): ?>
            <?php while ($row = $memberships->fetch_assoc()): ?>
                <tr>
                    <td><?= htmlspecialchars($row['professional_body_name']); ?></td>
                    <td><?= htmlspecialchars($row['amount']); ?></td>
                    <td><?= htmlspecialchars($row['membership_type']); ?></td>
                </tr>
            <?php endwhile; ?>
        <?php else: ?>
            <tr><td colspan="3">No memberships listed.</td></tr>
        <?php endif; ?>
    </table>

    <div class="section">Consumable / Item Details</div>
    <table>
        <tr><th>Serial No.</th><th>Article Name</th><th>Amount</th><th>Category</th></tr>
        <?php if ($items->num_rows > 0): ?>
            <?php while ($row = $items->fetch_assoc()): ?>
                <tr>
                    <td><?= htmlspecialchars($row['serial_number']); ?></td>
                    <td><?= htmlspecialchars($row['article_name']); ?></td>
                    <td><?= htmlspecialchars($row['amount']); ?></td>
                    <td><?= htmlspecialchars($row['item_category']); ?></td>
                </tr>
            <?php endwhile; ?>
        <?php else: ?>
            <tr><td colspan="4">No consumable items listed.</td></tr>
        <?php endif; ?>
    </table>

    <div class="section">HOD Recommendation</div>
    <form action="../controllers/HODController.php" method="POST">
        <input type="hidden" name="application_id" value="<?= $app['application_id']; ?>">
        <label>Comments:</label><br>
        <textarea name="comments" rows="4"></textarea><br><br>
        <button type="submit" name="action" value="recommend">✅ Recommend</button>
        <button type="submit" name="action" value="not_recommend">❌ Not Recommend</button>
    </form>

    <p><a href="hod_dashboard.php">⬅ Back to Dashboard</a></p>
</body>
</html>

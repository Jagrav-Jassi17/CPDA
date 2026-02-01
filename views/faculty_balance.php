<?php
session_start();
require_once '../config/db.php';
require_once '../controllers/BalanceViewController.php';

if (!isset($_SESSION['employee_code'])) {
    header("Location: login.php");
    exit();
}

$employee_code = $_SESSION['employee_code'];
$balanceCtrl = new BalanceViewController();

/*
|--------------------------------------------------------------------------
| 1. Current Approved Balance (GLOBAL SOURCE OF TRUTH)
|--------------------------------------------------------------------------
*/
$overallRemaining = $balanceCtrl->getCurrentApprovedBalance($employee_code);


/*
|--------------------------------------------------------------------------
| 2. Correct Projected Balance
|    = Approved Balance − SUM(amount of all pending applications)
|--------------------------------------------------------------------------
*/
$projectedBalance = $overallRemaining;

$stmtPending = $conn->prepare("
    SELECT application_id
    FROM cpda_applications
    WHERE employee_code = ?
      AND status NOT IN ('APPROVED')
");
$stmtPending->bind_param("s", $employee_code);
$stmtPending->execute();
$resPending = $stmtPending->get_result();

while ($row = $resPending->fetch_assoc()) {
    $amount = $balanceCtrl->getApplicationAmountPublic(
        'F1',
        (int)$row['application_id']
    );
    $projectedBalance -= $amount;
}

/*
|--------------------------------------------------------------------------
| 3. Fetch Form-1 Applications
|--------------------------------------------------------------------------
*/
$stmt = $conn->prepare("
    SELECT application_id, ref_number, created_at
    FROM cpda_applications
    WHERE employee_code = ?
    ORDER BY created_at DESC
");
$stmt->bind_param("s", $employee_code);
$stmt->execute();
$result = $stmt->get_result();
?>
<!DOCTYPE html>
<html>
<head>
    <title>CPDA Balance</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

<h2>📊 CPDA Balance</h2>

<div style="
    margin: 15px 0;
    padding: 15px;
    background: #e8f5e9;
    border-left: 6px solid #2e7d32;
    font-size: 18px;
">
    <strong>Overall Remaining CPDA Balance:</strong>
    ₹ <?= number_format($overallRemaining, 2) ?>
</div>

<div style="
    margin: 15px 0;
    padding: 15px;
    background: #e3f2fd;
    border-left: 6px solid #1565c0;
    font-size: 18px;
">
    <strong>Projected CPDA Balance (if all pending forms are approved):</strong>
    ₹ <?= number_format($projectedBalance, 2) ?>
</div>
<?php if ($projectedBalance < 0): ?>
    <div style="
        margin: 15px 0;
        padding: 15px;
        background: #ffebee;
        border-left: 6px solid #c62828;
        color: #b71c1c;
        font-size: 16px;
    ">
        ⚠️ <strong>Warning:</strong>
        Pending applications exceed the available CPDA balance.
        Some applications may be rejected during approval.
    </div>
<?php endif; ?>


<p><a href="faculty_dashboard.php">⬅ Back to Dashboard</a></p>

<table>
    <thead>
        <tr>
            <th>Reference No</th>
            <th>Balance After This Application</th>

            <th>Status</th>
            <th>Details</th>
        </tr>
    </thead>
    <tbody>
        <?php if ($result->num_rows > 0): ?>
            <?php while ($row = $result->fetch_assoc()): 
                $balance = $balanceCtrl->getBalanceByForm(
                    'F1',
                    (int)$row['application_id']
                );

                // FORCE global approved balance for every row
                $balance['approved_balance'] = $overallRemaining;

                // Balance after this application is approved

                $amount = $balanceCtrl->getApplicationAmountPublic(
                    'F1',
                    (int)$row['application_id']
                );
                $balance['temporary_balance'] = $overallRemaining - $amount;
            ?>
                <tr>
                    <td><?= htmlspecialchars($row['ref_number']) ?></td>
                    <td>₹ <?= number_format($balance['temporary_balance'], 2) ?></td>
                    <td>
                        <?php
                        switch ($balance['status']) {
                            case 'APPROVED':
                                echo '<span style="color: green; font-weight: bold;">Approved</span>';
                                break;
                            case 'TEMP':
                                echo '<span style="color: orange; font-weight: bold;">Pending Approval</span>';
                                break;
                            case 'COMPUTED':
                                echo '<span style="color: #555;">Calculated (Old Application)</span>';
                                break;
                            default:
                                echo htmlspecialchars($balance['status']);
                        }
                        ?>
                    </td>
                    <td>
                        <a href="balance_view.php?form_type=F1&form_id=<?= (int)$row['application_id'] ?>">
                            View
                        </a>
                    </td>
                </tr>
            <?php endwhile; ?>
        <?php else: ?>
            <tr>
                <td colspan="5">No applications found</td>
            </tr>
        <?php endif; ?>
    </tbody>
</table>

</body>
</html>

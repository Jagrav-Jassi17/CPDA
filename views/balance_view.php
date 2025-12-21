<?php
session_start();
require_once '../controllers/BalanceViewController.php';

if (!isset($_GET['form_type'], $_GET['form_id'])) {
    die("Invalid request");
}

$formType = $_GET['form_type'];   // F1, F2, F4, F5
$formId   = (int)$_GET['form_id'];

$ctrl = new BalanceViewController();
$balance = $ctrl->getBalanceByForm($formType, $formId);

if (!$balance) {
    die("Balance data not found");
}

$role = $_SESSION['role'] ?? 'FACULTY';

/*
|--------------------------------------------------------------------------
| FORCE CONSISTENT BALANCE DISPLAY
|--------------------------------------------------------------------------
*/
$currentApprovedBalance = $ctrl->getCurrentApprovedBalance();
$amount = $ctrl->getApplicationAmountPublic($formType, $formId);

$balance['approved_balance']  = $currentApprovedBalance;
$balance['temporary_balance'] = $currentApprovedBalance - $amount;

/*
|--------------------------------------------------------------------------
| HANDLE ACCOUNTS ACTIONS (F4 / F5 ONLY)
|--------------------------------------------------------------------------
*/
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $role === 'accounts_ar') {

    $remarks = trim($_POST['accounts_remarks'] ?? '');

    // Reject or Revert MUST have remarks
    if (in_array($_POST['action'], ['reject', 'revert']) && $remarks === '') {
        echo "<script>alert('Remarks are required.'); window.history.back();</script>";
        exit();
    }

    // APPROVE (F4/F5 only)
    if ($_POST['action'] === 'approve' && in_array($formType, ['F4', 'F5'])) {
        $ctrl->approveBalanceForApplication(
            $formType,
            $formId,
            $balance['temporary_balance'],
            $_SESSION['employee_code']
        );

        $ctrl->updateAccountsDecision(
            $formId,
            'APPROVED',
            null
        );
    }

    // REJECT
    if ($_POST['action'] === 'reject') {
        $ctrl->updateAccountsDecision(
            $formId,
            'REJECTED',
            $remarks
        );
    }

    // REVERT
    if ($_POST['action'] === 'revert') {
        $ctrl->updateAccountsDecision(
            $formId,
            'REVERTED',
            $remarks,
            true
        );
    }

    header("Location: balance_view.php?form_type=$formType&form_id=$formId");
    exit();
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>CPDA Balance</title>
    <style>
        table {
            border-collapse: collapse;
            width: 60%;
            margin: 30px auto;
        }
        th, td {
            border: 1px solid #444;
            padding: 10px;
            text-align: center;
        }
        th { background: #f2f2f2; }
        .approved { color: green; font-weight: bold; }
        .pending { color: orange; font-weight: bold; }
        .computed { color: #555; }
        textarea { width: 90%; height: 80px; }
        button { margin: 5px; padding: 8px 14px; }
    </style>
</head>
<body>

<h2 style="text-align:center;">CPDA Balance Summary</h2>

<table>
    <tr>
        <th>Form Type</th>
        <td><?= htmlspecialchars($formType) ?></td>
    </tr>
    <tr>
        <th>Approved CPDA Balance</th>
        <td>₹ <?= number_format($balance['approved_balance'], 2) ?></td>
    </tr>
    <tr>
        <th>Balance After This Application</th>
        <td>₹ <?= number_format($balance['temporary_balance'], 2) ?></td>
    </tr>
    <tr>
        <th>Status</th>
        <td class="<?= $balance['status'] === 'TEMP' ? 'pending' : 'approved' ?>">
            <?= htmlspecialchars($balance['status']) ?>
        </td>
    </tr>
</table>

<?php if ($role === 'accounts_ar' && in_array($formType, ['F4', 'F5'])): ?>
    <form method="post" style="text-align:center;">
        <h3>Accounts Action</h3>

        <textarea name="accounts_remarks" placeholder="Enter remarks (required for Reject / Revert)"></textarea><br>

        <button type="submit" name="action" value="approve">Approve</button>
        <button type="submit" name="action" value="reject">Reject</button>
        <button type="submit" name="action" value="revert">Revert for Correction</button>
    </form>

<?php elseif ($role === 'accounts_ar'): ?>
    <p style="text-align:center; color:#777;">
        No accounts action required for this form type.
    </p>
<?php endif; ?>

</body>
</html>

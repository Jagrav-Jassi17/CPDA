<?php
session_start();
include_once '../config/db.php';

if (!in_array($_SESSION['role'], ['accounts_da','accounts_supp','accounts_ar'])) {
    header("Location: ../views/login.php"); exit();
}

$application_id = isset($_GET['application_id']) ? $_GET['application_id'] : '';
if (!$application_id) die("Invalid application id.");

$stmt = $conn->prepare("SELECT * FROM cpda_applications WHERE application_id = ?");
$stmt->bind_param("s", $application_id);
$stmt->execute();
$app = $stmt->get_result()->fetch_assoc();
if (!$app) die("Application not found.");

$employee_code = $app['employee_code'];

// Fixed financial years for the 3-year block
$financial_years = [
    'Y1' => '2021-22',
    'Y2' => '2022-23',
    'Y3' => '2023-24'
];
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Enter Expenditure for <?= htmlspecialchars($app['faculty_name']) ?></title>
    <style>
        table{border-collapse:collapse; margin-bottom:20px; width:100%;}
        th,td{border:1px solid #ccc;padding:6px; text-align:left;}
        th{background-color:#f0f0f0;}
        input[type="number"], input[type="date"], input[type="text"]{width:100%; box-sizing:border-box;}
        h3{margin-top:30px; color:#333;}
        h4{margin-top:20px; color:#555;}
        .btn-group{margin-top:20px;}
        button{padding:10px 20px; margin-right:10px; cursor:pointer;}
    </style>
</head>
<body>
<h2>Expenditure Entry — <?= htmlspecialchars($app['faculty_name']) ?> (<?= htmlspecialchars($employee_code) ?>)</h2>
<p>Block Period: 2021-2024 (3 Years) | Application ID: <?= htmlspecialchars($application_id) ?></p>

<form method="post" action="../controllers/ExpenditureController.php">
    <input type="hidden" name="application_id" value="<?= htmlspecialchars($application_id) ?>">
    <input type="hidden" name="employee_code" value="<?= htmlspecialchars($employee_code) ?>">

    <h3>POINT 1: National/International Conferences/Workshops (limit: 70% / block)</h3>
    <table>
        <tr>
            <th>Financial Year</th>
            <th>No. of Events (Days)</th>
            <th>Amount Spent</th>
            <th>Amount Committed</th>
            <th>Balance</th>
        </tr>
        <?php foreach($financial_years as $key => $year): ?>
        <tr>
            <td><?= $year ?></td>
            <td><input type="number" min="0" name="P1_Conferences_<?= $key ?>_Num_Events" value="0"></td>
            <td><input type="number" step="0.01" min="0" name="P1_Conferences_<?= $key ?>_Amt_Spent" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P1_Conferences_<?= $key ?>_Amt_Committed" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P1_Conferences_<?= $key ?>_Balance" value="0.00"></td>
        </tr>
        <?php endforeach; ?>
    </table>

    <h3>POINT 2: Membership of Professional Bodies (max 3 per year)</h3>
    <table>
        <tr>
            <th>Financial Year</th>
            <th>No. Availed</th>
            <th>Amount Spent</th>
            <th>Amount Committed</th>
            <th>Balance</th>
        </tr>
        <?php foreach($financial_years as $key => $year): ?>
        <tr>
            <td><?= $year ?></td>
            <td><input type="number" min="0" name="P2_Membership_<?= $key ?>_Num_Availed" value="0"></td>
            <td><input type="number" step="0.01" min="0" name="P2_Membership_<?= $key ?>_Amt_Spent" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P2_Membership_<?= $key ?>_Amt_Committed" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P2_Membership_<?= $key ?>_Balance" value="0.00"></td>
        </tr>
        <?php endforeach; ?>
    </table>

    <h3>POINT 3: Contingent Expenses (Total for 3-year block)</h3>
    
    <h4>Item 3a: Consumables (Chemicals, Laboratory, Glassware etc.)</h4>
    <table>
        <tr>
            <th>No. Availed</th>
            <th>Amount Spent</th>
            <th>Amount Committed</th>
            <th>Balance</th>
        </tr>
        <tr>
            <td><input type="number" min="0" name="P3a_Consumables_Num_Availed" value="0"></td>
            <td><input type="number" step="0.01" min="0" name="P3a_Consumables_Amt_Spent" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3a_Consumables_Amt_Committed" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3a_Consumables_Balance" value="0.00"></td>
        </tr>
    </table>

    <h4>Item 3b: Charges for Synthesis/Analysis/Testing of Samples</h4>
    <table>
        <tr>
            <th>No. Availed</th>
            <th>Amount Spent</th>
            <th>Amount Committed</th>
            <th>Balance</th>
        </tr>
        <tr>
            <td><input type="number" min="0" name="P3b_Synthesis_Testing_Num_Availed" value="0"></td>
            <td><input type="number" step="0.01" min="0" name="P3b_Synthesis_Testing_Amt_Spent" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3b_Synthesis_Testing_Amt_Committed" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3b_Synthesis_Testing_Balance" value="0.00"></td>
        </tr>
    </table>

    <h4>Item 3c(i): Stationary & Related Items</h4>
    <table>
        <tr>
            <th>No. Availed</th>
            <th>Amount Spent</th>
            <th>Amount Committed</th>
            <th>Balance</th>
        </tr>
        <tr>
            <td><input type="number" min="0" name="P3c_i_Stationary_Num_Availed" value="0"></td>
            <td><input type="number" step="0.01" min="0" name="P3c_i_Stationary_Amt_Spent" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3c_i_Stationary_Amt_Committed" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3c_i_Stationary_Balance" value="0.00"></td>
        </tr>
    </table>

    <h4>Item 3c(ii): Books (including e-Books)</h4>
    <table>
        <tr>
            <th>No. Availed</th>
            <th>Amount Spent</th>
            <th>Amount Committed</th>
            <th>Balance</th>
        </tr>
        <tr>
            <td><input type="number" min="0" name="P3c_ii_Books_Num_Availed" value="0"></td>
            <td><input type="number" step="0.01" min="0" name="P3c_ii_Books_Amt_Spent" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3c_ii_Books_Amt_Committed" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3c_ii_Books_Balance" value="0.00"></td>
        </tr>
    </table>

    <h4>Item 3d: Computer Related Consumables (Storage Media, Cartridges etc.)</h4>
    <table>
        <tr>
            <th>No. Availed</th>
            <th>Amount Spent</th>
            <th>Amount Committed</th>
            <th>Balance</th>
        </tr>
        <tr>
            <td><input type="number" min="0" name="P3d_Computer_Consumables_Num_Availed" value="0"></td>
            <td><input type="number" step="0.01" min="0" name="P3d_Computer_Consumables_Amt_Spent" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3d_Computer_Consumables_Amt_Committed" value="0.00"></td>
            <td><input type="number" step="0.01" min="0" name="P3d_Computer_Consumables_Balance" value="0.00"></td>
        </tr>
    </table>

    <h3>POINT 4: Electronic Devices Issued in Last 5 Years (Office Record)</h3>
    <table>
        <tr>
            <th>S. No.</th>
            <th>Item Description</th>
            <th>Date of Issue</th>
            <th>Cost at Time of Issue</th>
        </tr>
        <?php for($i=1; $i<=5; $i++): ?>
        <tr>
            <td><input type="text" name="devices[<?= $i ?>][S_No]" placeholder="<?= $i ?>"></td>
            <td><input type="text" name="devices[<?= $i ?>][Item_Description]"></td>
            <td><input type="date" name="devices[<?= $i ?>][Date_of_Issue]"></td>
            <td><input type="number" step="0.01" min="0" name="devices[<?= $i ?>][Cost_at_Time_of_Issue]"></td>
        </tr>
        <?php endfor; ?>
    </table>

    <div class="btn-group">
        <button type="submit" name="action" value="save_da">Save (DA)</button>
        <button type="submit" name="action" value="save_and_forward">Save & Forward to Superintendent</button>
        <button type="button" onclick="window.history.back()">Cancel</button>
    </div>
</form>
</body>
</html>
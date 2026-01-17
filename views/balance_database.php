<?php
session_start();
include_once '../config/db.php';

// if ($_SESSION['role'] !== 'accounts_ar') {
//     header("Location: login.php");
//     exit();
// }
// if (isset($_SESSION['employee_code'])) {
//     $search_employee_code = $_SESSION['employee_code'];
//     echo "Accessing data for Employee: " . htmlspecialchars($search_employee_code);
// } else {
//     echo "Session expired. Please login again.";
// }
$role = $_POST['role'] ?? $_GET['role'] ?? '';
$search_employee_code = $_POST['employee_code'] ?? $_GET['employee_code'] ?? '';
$action = $_POST['action'] ?? '';

// Handle search
$results = [];
if ($search_employee_code) {
    $stmt = $conn->prepare("SELECT * FROM fdx_expenditure_main WHERE employee_code LIKE ? ");
    $search_param = "%$search_employee_code%";
    $stmt->bind_param("s", $search_param);
    $stmt->execute();
    $results = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}
$results1 = [];
if ($search_employee_code) {
    $stmt = $conn->prepare("SELECT * FROM fdx_electronic_devices WHERE employee_code LIKE ? ");
    $search_param = "%$search_employee_code%";
    $stmt->bind_param("s", $search_param);
    $stmt->execute();
    $results1 = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
}


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Balance sheet </title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f5f5f5; }
        .container { max-width: 1400px; margin: 20px auto; background: white; padding: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; border-bottom: 3px solid #3498db; padding-bottom: 10px; }
        .search-section { background: #ecf0f1; padding: 20px; border-radius: 8px; margin-bottom: 30px; }
        .search-box { display: flex; gap: 10px; max-width: 500px; }
        input[type="text"] { flex: 1; padding: 12px; border: 2px solid #bdc3c7; border-radius: 5px; font-size: 16px; }
        button { padding: 12px 25px; background: #3498db; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
        button:hover { background: #2980b9; }
        .table-container { overflow-x: auto; margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th { background: #34495e; color: white; padding: 15px 12px; text-align: left; font-weight: 600; position: sticky; top: 0; }
        td { padding: 12px; border-bottom: 1px solid #ecf0f1; }
        tr:nth-child(even) { background: #f8f9fa; }
        tr:hover { background: #e3f2fd; }
        .status-approved { background: #d4edda; color: #155724; }
        .status-pending { background: #fff3cd; color: #856404; }
        .btn-edit { background: #f39c12; color: white; padding: 8px 15px; text-decoration: none; border-radius: 4px; font-size: 14px; }
        .btn-edit:hover { background: #e67e22; }
        .btn-delete { background: #e74c3c; color: white; padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; margin-left: 5px; }
        .no-results { text-align: center; padding: 50px; color: #7f8c8d; font-style: italic; }
        .success { background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin: 20px 0; }
        .error { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin: 20px 0; }
        .summary { background: #e8f4fd; padding: 20px; border-radius: 8px; margin-bottom: 30px; }
        .summary h3 { margin-top: 0; color: #2980b9; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 Balance Sheet</h1>
        
        <!-- Success/Error Messages -->
        <?php if (isset($success_msg)): ?>
            <div class="success"><?= htmlspecialchars($success_msg); ?></div>
        <?php endif; ?>
        <?php if (isset($error_msg)): ?>
            <div class="error"><?= htmlspecialchars($error_msg); ?></div>
        <?php endif; ?>

        
        <!-- Results Summary -->
        <?php if ($results): ?>
            <div class="summary">
                <p><strong>Employee Code:</strong> <?= htmlspecialchars($search_employee_code); ?></p>
            </div>
        <?php endif; ?>

        <!-- Results Table -->
        <?php if ($results): ?>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th rowspan="2">Sr No.</th>
                            <th rowspan="2">Item</th>
                            <th rowspan="2">Limit</th>
                            <th colspan="4">Expenditure</th>
                            <th rowspan="2">Balance</th>
                            
                        </tr>
                        <tr>
                            <th></th>
                            <th>Block Year 1</th>
                            <th>Block Year 2</th>
                            <th>Block Year 3</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($results as $record): ?>
                            <tr>
                                <tr>
                                    <td rowspan="3">1</td>
                                    <td rowspan="3">National/International Conferences</td>
                                    <td rowspan="3">Up to 70% i.e. Rs.2,10,000 in block of 3 years</td>

                                    <td>No. of events attended during working days</td>
                                    <td><?= number_format($record['P1_Conferences_Y1_Num_Events'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y2_Num_Events'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y3_Num_Events'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y1_Balance'], 2); ?></td>
                                </tr>

                                <tr>
                                    <td>Amount Spent</td>
                                    <td><?= number_format($record['P1_Conferences_Y1_Amt_Spent'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y2_Amt_Spent'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y3_Amt_Spent'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y2_Balance'], 2); ?></td>
                                </tr>

                                <tr>
                                    <td>Amount Commited</td>
                                    <td><?= number_format($record['P1_Conferences_Y1_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y2_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y3_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P1_Conferences_Y3_Balance'], 2); ?></td>
                                </tr>
                            </tr>
                            <tr>
                                <tr>
                                    <td rowspan="3">2</td>
                                    <td rowspan="3">Memberships of Professional Bodies</td>
                                    <td rowspan="3">03 new memberships or renewal of earlier memberships per year</td>

                                    <td>Number Availed</td>
                                    <td><?= number_format($record['P2_Membership_Y1_Num_Availed'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y2_Num_Availed'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y3_Num_Availed'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y1_Balance'], 2); ?></td>
                                </tr>

                                <tr>
                                    <td>Amount Spent</td>
                                    <td><?= number_format($record['P2_Membership_Y1_Amt_Spent'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y2_Amt_Spent'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y3_Amt_Spent'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y2_Balance'], 2); ?></td>
                                </tr>

                                <tr>
                                    <td>Amount Commited</td>
                                    <td><?= number_format($record['P2_Membership_Y1_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y2_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y3_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P2_Membership_Y3_Balance'], 2); ?></td>
                                </tr>
                            </tr>
                            <tr>
                                    <td >3</td>
                                    <td colspan="7">National/International Conferences</td>
                            </tr>
                            <tr>
                                    <td >a.</td>
                                    <td >Consumables such as Chemicals, Laboratory, Glassware etc.</td>
                                    <td >Rs.60,000/- in a block of 3 years @ Rs.20,000/- per financial year</td>
                                    <td ></td>
                                    <td><?= number_format($record['P3a_Consumables_Y1_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3a_Consumables_Y2_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3a_Consumables_Y3_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3a_Consumables_Balance'], 2); ?></td>
                            </tr>
                            <tr>
                                    <td >b.</td>
                                    <td >Charges for Synthesis, Analysis/Testing of Sampes for research purposes</td>
                                    <td >Rs.60,000/- in a block of 3 years @ Rs.20,000/- per financial year</td>
                                    <td ></td>
                                    <td><?= number_format($record['P3b_Synthesis_Testing_Y1_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3b_Synthesis_Testing_Y2_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3b_Synthesis_Testing_Y3_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3b_Synthesis_Testing_Balance'], 2); ?></td>
                            </tr>
                            <tr>
                                <td rowspan="2">c.</td>
                                    <td >Stationary & related items</td>
                                    <td >Rs.30,000/- in a block of 3 years @ Rs.10,000/- per financial year</td>
                                    <td ></td>
                                    <td><?= number_format($record['P3c_i_Stationary_Y1_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3c_i_Stationary_Y2_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3c_i_Stationary_Y3_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3c_i_Stationary_Balance'], 2); ?></td>

                                <tr>
                                        <td >Books (including e-Books)</td>
                                        <td >Rs.50,000/- in a block of 3 years </td>
                                        <td ></td>
                                        <td><?= number_format($record['P3c_ii_Books_Y1_Amt_Committed'], 2); ?></td>
                                        <td><?= number_format($record['P3c_ii_Books_Y2_Amt_Committed'], 2); ?></td>
                                        <td><?= number_format($record['P3c_ii_Books_Y3_Amt_Committed'], 2); ?></td>
                                        <td><?= number_format($record['P3c_ii_Books_Balance'], 2); ?></td>
                                </tr>
                            </tr>
                            <tr>
                                    <td >d.</td>
                                    <td >Computer related consumables such as External Storage devices, cartridges etc.</td>
                                    <td >Rs.60,000/- in a block of 3 years @ Rs.20,000/- per financial year</td>
                                    <td ></td>
                                    <td><?= number_format($record['P3d_Computer_Consumables_Y1_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3d_Computer_Consumables_Y2_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3d_Computer_Consumables_Y3_Amt_Committed'], 2); ?></td>
                                    <td><?= number_format($record['P3d_Computer_Consumables_Balance'], 2); ?></td>
                            </tr>

                        <?php endforeach; ?>
                    </tbody> 
                </table>
            </div>
            <div class="table-container">
                <h3>4. Additional Items (Laptop/tablet/notebook/Electronic devices issued to the faculty member during last five years)</h3>
                <table>
                    <thead>
                        <tr>
                            <th >Sr No.</th>
                            <th >Item</th>
                            <th >Date of issue</th>
                            <th >Cost at the time of issue</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($results1 as $record): ?>
                            <tr>
                                    <td><?= $record['S_No']; ?></td>
                                    <td><?= $record['Item_Description']; ?></td>
                                    <td><?= $record['Date_of_Issue']; ?></td>
                                    <td><?= number_format($record['Cost_at_Time_of_Issue'], 2); ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php elseif ($search_employee_code): ?>
            <div class="no-results">
                <h3>📭 No records found</h3>
                <p>No F1 records found for employee code: <strong><?= htmlspecialchars($search_employee_code); ?></strong></p>
            </div>
        <?php endif; ?>

        

</body>
</html>


<?php
session_start();
if ($_SESSION['role'] !== 'faculty') {
    header("Location: login.php");
    exit();
}
include_once '../config/db.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>CPDA Form 1 - Faculty</title>
<style>
    body { font-family: Arial, sans-serif; margin: 40px; }
    label { display:block; margin-top:10px; }
    input, textarea, select { width: 100%; padding:8px; margin-top:5px; }
    table { width:100%; border-collapse: collapse; margin-top:10px; }
    th, td { border:1px solid #ccc; padding:6px; text-align:left; }
    button { margin-top:15px; padding:8px 15px; }
    .add-row { margin-top:5px; background:#28a745; color:white; border:none; }
    .remove-row { background:#dc3545; color:white; border:none; padding:4px 8px; }
</style>
<script>
function addMembershipRow() {
    const table = document.getElementById('membershipTable');
    const row = table.insertRow();
    row.innerHTML = `
        <td><input type="text" name="membership_body_name[]" required></td>
        <td><input type="number" name="membership_amount[]" step="0.01" required></td>
        <td>
            <select name="membership_type[]">
                <option value="NATIONAL">National</option>
                <option value="INTERNATIONAL">International</option>
                <option value="BOTH">Both</option>
            </select>
        </td>
        <td><button type="button" class="remove-row" onclick="this.closest('tr').remove()">X</button></td>
    `;
}
function addConsumableRow() {
    const table = document.getElementById('consumableTable');
    const row = table.insertRow();
    row.innerHTML = `
        <td><input type="text" name="article_name[]" required></td>
        <td><input type="number" name="article_amount[]" step="0.01" required></td>
        <td>
            <select name="item_category[]">
                <option value="CHEMICALS">Chemicals</option>
                <option value="LABORATORY_GLASSWARE">Lab Glassware</option>
                <option value="SYNTHESIS_CHARGES">Synthesis Charges</option>
                <option value="ANALYSIS_CHARGES">Analysis Charges</option>
                <option value="STATIONARY">Stationary</option>
                <option value="BOOKS">Books</option>
                <option value="COMPUTER_CONSUMABLES">Computer Consumables</option>
                <option value="EXTERNAL_STORAGE">External Storage</option>
                <option value="CARTRIDGES">Cartridges</option>
                <option value="PATENT">Patent</option>
                <option value="OTHER">Other</option>
            </select>
        </td>
        <td><button type="button" class="remove-row" onclick="this.closest('tr').remove()">X</button></td>
    `;
}
</script>
</head>
<body>

<h2>CPDA Application Form 1 (Block Year 20__ to 20__)</h2>

<form method="POST" action="../controllers/form1_submit.php">
    <input type="hidden" name="employee_code" value="<?= $_SESSION['employee_code']; ?>">
    <label>Faculty Name</label>
    <input type="text" name="faculty_name" value="<?= $_SESSION['name']; ?>" readonly>

    <label>Email</label>
    <input type="email" name="email" value="<?= $_SESSION['email']; ?>" readonly>

    <label>Mobile Number</label>
    <input type="text" name="mobile_number" value="<?= $_SESSION['mobile_number']; ?>" readonly>
    <label>Designation</label>
    <input type="text" name="designation" value="<?= $_SESSION['role']; ?>" readonly>

    <label>Department</label>
    <input type="text" name="department" value="<?= $_SESSION['department']; ?>" readonly>

    <label>Pay Level</label>
    <input type="text" name="pay_level" value="<?= $_SESSION['pay_level']; ?>" readonly>

    <label>Date of Joining</label>
    <input type="date" name="date_of_joining" value="<?= $_SESSION['date_of_joining']; ?>" readonly>

    <label>Purpose of Purchase</label>
    <textarea name="purpose_of_purchase" rows="3" required></textarea>

    <label>Technical Specification (Source of Information)</label>
    <textarea name="technical_specification" rows="3"></textarea>

    <label>Remarks (if any)</label>
    <textarea name="remarks" rows="3"></textarea>

    <h3>Professional Memberships</h3>
    <table id="membershipTable">
        <tr>
            <th>Professional Body Name</th>
            <th>Amount (₹)</th>
            <th>Type</th>
            <th>Action</th>
        </tr>
    </table>
    <button type="button" class="add-row" onclick="addMembershipRow()">+ Add Membership</button>

    <h3>Consumable Items</h3>
    <table id="consumableTable">
        <tr>
            <th>Article Name</th>
            <th>Amount (₹)</th>
            <th>Category</th>
            <th>Action</th>
        </tr>
    </table>
    <button type="button" class="add-row" onclick="addConsumableRow()">+ Add Item</button>

    <button type="submit">Submit Form</button>
</form>

</body>
</html>

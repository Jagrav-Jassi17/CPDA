<?php include('../../config/db.php'); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PDA Block Form</title>
    <link rel="stylesheet" href="../../assets/css/style.css">
</head>
<body>
<h2>PDA Block Form (20__ to 20__)</h2>

<form action="../../controllers/FormController.php" method="POST">
    <input type="hidden" name="user_id" value="<!-- PHP code to fetch user_id from session -->">

    <label>Block Year From:</label>
    <input type="number" name="block_year_from" required>

    <label>Block Year To:</label>
    <input type="number" name="block_year_to" required>

    <label>Purpose of Purchase:</label>
    <textarea name="purpose" required></textarea>

    <label>Technical Specifications:</label>
    <textarea name="tech_spec"></textarea>

    <label>Remarks (if any):</label>
    <textarea name="remarks"></textarea>

    <h3>Membership of Professional Bodies</h3>
    <table id="membershipTable">
        <tr><th>Body Name</th><th>Amount</th></tr>
        <tr>
            <td><input type="text" name="membership_body[]"></td>
            <td><input type="number" step="0.01" name="membership_amount[]"></td>
        </tr>
    </table>
    <button type="button" onclick="addMembership()">+ Add Row</button>

    <h3>Consumables / Items</h3>
    <table id="consumablesTable">
        <tr><th>Article Name</th><th>Amount</th></tr>
        <tr>
            <td><input type="text" name="article_name[]"></td>
            <td><input type="number" step="0.01" name="article_amount[]"></td>
        </tr>
    </table>
    <button type="button" onclick="addConsumable()">+ Add Row</button>

    <br><br>
    <button type="submit" name="submitForm">Submit Form</button>
</form>

<script>
function addMembership() {
    const row = '<tr><td><input type="text" name="membership_body[]"></td><td><input type="number" step="0.01" name="membership_amount[]"></td></tr>';
    document.getElementById('membershipTable').insertAdjacentHTML('beforeend', row);
}

function addConsumable() {
    const row = '<tr><td><input type="text" name="article_name[]"></td><td><input type="number" step="0.01" name="article_amount[]"></td></tr>';
    document.getElementById('consumablesTable').insertAdjacentHTML('beforeend', row);
}
</script>

</body>
</html>

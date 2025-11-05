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
<title>F-4 Reimbursement Form - Faculty</title>
<style>
    body { font-family: Arial, sans-serif; margin: 40px; background-color: #f5f5f5; }
    .container { max-width: 900px; margin: 0 auto; background: white; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h2 { color: #2c3e50; border-bottom: 3px solid #3498db; padding-bottom: 10px; }
    h3 { color: #34495e; margin-top: 25px; border-bottom: 2px solid #95a5a6; padding-bottom: 8px; }
    label { display: block; margin-top: 12px; font-weight: bold; color: #333; }
    input, textarea, select { width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; box-sizing: border-box; }
    input:focus, textarea:focus, select:focus { outline: none; border-color: #3498db; }
    input[readonly] { background-color: #ecf0f1; cursor: not-allowed; }
    table { width: 100%; border-collapse: collapse; margin-top: 15px; }
    th, td { border: 1px solid #bdc3c7; padding: 10px; text-align: left; }
    th { background-color: #3498db; color: white; font-weight: bold; }
    button { margin-top: 20px; padding: 10px 20px; cursor: pointer; border: none; border-radius: 4px; font-size: 14px; font-weight: bold; }
    button[type="submit"] { background: #27ae60; color: white; font-size: 16px; padding: 12px 30px; }
    button[type="submit"]:hover { background: #229954; }
    .add-row { background: #3498db; color: white; margin-top: 10px; padding: 8px 16px; }
    .add-row:hover { background: #2980b9; }
    .remove-row { background: #e74c3c; color: white; padding: 5px 10px; font-size: 12px; }
    .remove-row:hover { background: #c0392b; }
    .expense-row { margin-bottom: 15px; padding: 15px; background: #f9f9f9; border-radius: 4px; border-left: 4px solid #3498db; }
    .expense-row label { margin-top: 5px; }
    .total-section { background: #ecf0f1; padding: 15px; border-radius: 4px; margin-top: 20px; text-align: right; }
    .total-amount { font-size: 20px; font-weight: bold; color: #27ae60; }
    .info-text { font-size: 12px; color: #7f8c8d; font-style: italic; margin-top: 3px; }
    .required { color: #e74c3c; }
</style>
<script>
function calculateTotal() {
    let total = 0;
    
    // Calculate membership fees
    const membershipAmounts = document.querySelectorAll('input[name="membership_amount[]"]');
    membershipAmounts.forEach(input => {
        const value = parseFloat(input.value) || 0;
        total += value;
    });
    
    // Calculate expense amounts
    const expenseAmounts = document.querySelectorAll('.expense-amount');
    expenseAmounts.forEach(input => {
        const value = parseFloat(input.value) || 0;
        total += value;
    });
    
    document.getElementById('totalAmount').textContent = '₹ ' + total.toFixed(2);
    document.getElementById('totalAmountHidden').value = total.toFixed(2);
}

function addMembershipRow() {
    const table = document.getElementById('membershipTable');
    const row = table.insertRow();
    row.innerHTML = `
        <td><input type="text" name="membership_body_name[]" required></td>
        <td><input type="number" name="membership_amount[]" step="0.01" min="0" oninput="calculateTotal()" required></td>
        <td>
            <select name="membership_type[]" required>
                <option value="">Select Type</option>
                <option value="NATIONAL">National</option>
                <option value="INTERNATIONAL">International</option>
            </select>
        </td>
        <td style="text-align: center;">
            <button type="button" class="remove-row" onclick="this.closest('tr').remove(); calculateTotal();">Remove</button>
        </td>
    `;
}

document.addEventListener('DOMContentLoaded', function() {
    // Add initial event listeners for amount calculation
    document.querySelectorAll('.expense-amount').forEach(input => {
        input.addEventListener('input', calculateTotal);
    });
});

function addFileUploadRow() {
    const table = document.getElementById('fileUploadTable');
    const row = table.insertRow();
    row.innerHTML = `
        <td>
            <select name="attachment_types[]" required>
                <option value="RECEIPT">Receipt</option>
                <option value="INVOICE">Invoice</option>
                <option value="BILL">Bill</option>
                <option value="MEMBERSHIP_PROOF">Membership Proof</option>
                <option value="BOOK_INVOICE">Book Invoice</option>
                <option value="PATENT_DOCUMENT">Patent Document</option>
                <option value="OTHER">Other</option>
            </select>
        </td>
        <td>
            <input type="file" name="attachments[]" accept=".pdf,.jpg,.jpeg,.png" required>
        </td>
        <td>
            <input type="text" name="attachment_descriptions[]" placeholder="Brief description">
        </td>
        <td style="text-align: center;">
            <button type="button" class="remove-row" onclick="this.closest('tr').remove()">Remove</button>
        </td>
    `;
}
</script>
</head>
<body>

<div class="container">
    <h2>F-4: Reimbursement Form - CPDA</h2>
    <p class="info-text">Proforma for claiming reimbursement of expenses incurred on Membership of Professional bodies and Contingent expenses by faculty members under Cumulative Professional Development Allowance</p>

        <form method="POST" action="../controllers/form3_submit.php" enctype="multipart/form-data">
        <input type="hidden" name="employee_code" value="<?= $_SESSION['employee_code']; ?>">
        <input type="hidden" id="totalAmountHidden" name="total_amount" value="0">

        <h3>Faculty Information</h3>

        <label>Employee Code (Smile ERP) <span class="required">*</span></label>
        <input type="text" name="employee_code_display" value="<?= $_SESSION['employee_code']; ?>" readonly>

        <label>Faculty Name <span class="required">*</span></label>
        <input type="text" name="faculty_name" value="<?= $_SESSION['name']; ?>" readonly>

        <label>Designation <span class="required">*</span></label>
        <select name="designation" disabled>
            <option value="Assistant Professor" <?= $_SESSION['role'] === 'Assistant Professor' ? 'selected' : ''; ?>>Assistant Professor</option>
            <option value="Associate Professor" <?= $_SESSION['role'] === 'Associate Professor' ? 'selected' : ''; ?>>Associate Professor</option>
            <option value="Professor" <?= $_SESSION['role'] === 'Professor' ? 'selected' : ''; ?>>Professor</option>
            <option value="Professor (HAG)" <?= $_SESSION['role'] === 'Professor (HAG)' ? 'selected' : ''; ?>>Professor (HAG)</option>
        </select>
        <input type="hidden" name="designation" value="<?= $_SESSION['role']; ?>">

        <label>Pay Level <span class="required">*</span></label>
        <select name="pay_level" disabled>
            <option value="10" <?= $_SESSION['pay_level'] == '10' ? 'selected' : ''; ?>>Pay Level 10</option>
            <option value="11" <?= $_SESSION['pay_level'] == '11' ? 'selected' : ''; ?>>Pay Level 11</option>
            <option value="12" <?= $_SESSION['pay_level'] == '12' ? 'selected' : ''; ?>>Pay Level 12</option>
            <option value="13A2" <?= $_SESSION['pay_level'] == '13A2' ? 'selected' : ''; ?>>Pay Level 13A2</option>
            <option value="14A" <?= $_SESSION['pay_level'] == '14A' ? 'selected' : ''; ?>>Pay Level 14A</option>
            <option value="15" <?= $_SESSION['pay_level'] == '15' ? 'selected' : ''; ?>>Pay Level 15</option>
        </select>
        <input type="hidden" name="pay_level" value="<?= $_SESSION['pay_level']; ?>">

        <label>Department <span class="required">*</span></label>
        <input type="text" name="department" value="<?= $_SESSION['department']; ?>" readonly>

        <h3>Professional Membership Details</h3>
        <p class="info-text">Membership fee of Professional body</p>
        <table id="membershipTable">
            <thead>
                <tr>
                    <th>Professional Body Name</th>
                    <th>Amount (₹)</th>
                    <th>Type (National/International)</th>
                    <th style="width: 100px;">Action</th>
                </tr>
            </thead>
            <tbody>
                <!-- Rows will be added dynamically -->
            </tbody>
        </table>
        <button type="button" class="add-row" onclick="addMembershipRow()">+ Add Membership</button>

        <h3>Details of Expenses</h3>
        
        <div class="expense-row">
            <label>(a) Books - पुस्तकें</label>
            <input type="number" name="expense_books" class="expense-amount" step="0.01" min="0" value="0" oninput="calculateTotal()">
        </div>

        <div class="expense-row">
            <label>(b) Stationary Items - स्टेशनरी सामग्री</label>
            <input type="number" name="expense_stationary" class="expense-amount" step="0.01" min="0" value="0" oninput="calculateTotal()">
        </div>

        <div class="expense-row">
            <label>(c) Patent - पेटेंट</label>
            <input type="number" name="expense_patent" class="expense-amount" step="0.01" min="0" value="0" oninput="calculateTotal()">
        </div>

        <div class="expense-row">
            <label>(d) Computer Consumables (External Storage Devices, Cartridges) - संगणक सम्बन्धित उपभोग्य</label>
            <input type="number" name="expense_computer_consumables" class="expense-amount" step="0.01" min="0" value="0" oninput="calculateTotal()">
        </div>

        <div class="expense-row">
            <label>(e) Consumables (Chemicals, Laboratory Glassware) - उपभोग्य (रसायन, प्रयोगशाला काँच सामग्री)</label>
            <input type="number" name="expense_consumables" class="expense-amount" step="0.01" min="0" value="0" oninput="calculateTotal()">
        </div>

        <div class="expense-row">
            <label>(f) Charges for Synthesis & Analysis of Samples - नमूने का संश्लेषण व विश्लेषण शुल्क</label>
            <input type="number" name="expense_synthesis_analysis" class="expense-amount" step="0.01" min="0" value="0" oninput="calculateTotal()">
        </div>

        <div class="total-section">
            <label>Total Amount (कुल):</label>
            <div class="total-amount" id="totalAmount">₹ 0.00</div>
        </div>
        <h3>Upload Supporting Documents</h3>
        <p class="info-text">Please upload bills, receipts, invoices, and membership proofs</p>

        <div id="fileUploadSection">
            <table style="width: 100%; margin-top: 15px;">
                <thead>
                    <tr>
                        <th>Document Type</th>
                        <th>Choose File</th>
                        <th>Description</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="fileUploadTable">
                    <tr>
                        <td>
                            <select name="attachment_types[]" required>
                                <option value="RECEIPT">Receipt</option>
                                <option value="INVOICE">Invoice</option>
                                <option value="BILL">Bill</option>
                                <option value="MEMBERSHIP_PROOF">Membership Proof</option>
                                <option value="BOOK_INVOICE">Book Invoice</option>
                                <option value="PATENT_DOCUMENT">Patent Document</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </td>
                        <td>
                            <input type="file" name="attachments[]" accept=".pdf,.jpg,.jpeg,.png" required>
                        </td>
                        <td>
                            <input type="text" name="attachment_descriptions[]" placeholder="Brief description">
                        </td>
                        <td style="text-align: center;">
                            <button type="button" class="remove-row" onclick="this.closest('tr').remove()">Remove</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <button type="button" class="add-row" onclick="addFileUploadRow()">+ Add More Files</button>
        </div>

        <label>Remarks (if any) - टिप्पणी</label>
        <textarea name="remarks" rows="3" placeholder="Enter any additional remarks..."></textarea>

        <button type="submit">Submit Reimbursement Form</button>
    </form>
</div>
</body>
</html>

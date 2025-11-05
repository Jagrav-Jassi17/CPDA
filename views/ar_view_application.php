<?php
session_start();
include_once '../config/db.php';

// Redirect if not Assistant Registrar
if (!isset($_SESSION['employee_code']) || $_SESSION['role'] !== 'accounts_ar') {
    header("Location: ../login.php");
    exit();
}

$app_id = $_GET['application_id'] ?? null;
$type = $_GET['type'] ?? 'f4';

if (!$app_id) {
    die("Invalid application ID.");
}

if ($type === 'f5') {
    // Fetch F-5 Conference Reimbursement Application
    $stmt = $conn->prepare("SELECT * FROM f5_conference_reimbursements WHERE application_id = ?");
    $stmt->bind_param("i", $app_id);
    $stmt->execute();
    $app = $stmt->get_result()->fetch_assoc();
    
    if (!$app) {
        die("F-5 application not found.");
    }
    
    // Fetch attachments
    $stmt2 = $conn->prepare("SELECT * FROM f5_attachments WHERE reimbursement_id = ?");
    $stmt2->bind_param("i", $app_id);
    $stmt2->execute();
    $attachments = $stmt2->get_result();
    
} elseif ($type === 'f4') {
    // Fetch F-4 Application
    $stmt = $conn->prepare("SELECT * FROM f4_reimbursement_applications WHERE application_id = ?");
    $stmt->bind_param("i", $app_id);
    $stmt->execute();
    $app = $stmt->get_result()->fetch_assoc();
    
    if (!$app) {
        die("F-4 application not found.");
    }
    
    // Fetch memberships
    $stmt2 = $conn->prepare("SELECT * FROM f4_professional_memberships WHERE application_id = ?");
    $stmt2->bind_param("i", $app_id);
    $stmt2->execute();
    $memberships = $stmt2->get_result();
    
    // Fetch attachments
    $stmt3 = $conn->prepare("SELECT * FROM f4_reimbursement_attachments WHERE application_id = ?");
    $stmt3->bind_param("i", $app_id);
    $stmt3->execute();
    $attachments = $stmt3->get_result();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AR - Final Approval</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { color: #333; border-bottom: 3px solid #28a745; padding-bottom: 10px; }
        h3 { color: #555; margin-top: 25px; background: #d4edda; padding: 10px; border-left: 4px solid #28a745; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 25px; background: white; }
        table, th, td { border: 1px solid #ddd; }
        th { background-color: #f0f0f0; padding: 10px; text-align: left; width: 250px; font-weight: bold; }
        td { padding: 10px; }
        .section-header { background: #28a745; color: white; padding: 12px; font-weight: bold; font-size: 16px; }
        textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-family: Arial, sans-serif; }
        .button-group { margin-top: 30px; padding: 20px; background: #f9f9f9; border: 2px solid #28a745; border-radius: 5px; }
        button { padding: 12px 25px; margin: 5px; cursor: pointer; border: none; border-radius: 4px; font-size: 16px; font-weight: bold; }
        .btn-approve { background: #28a745; color: white; }
        .btn-approve:hover { background: #218838; }
        .btn-reject { background: #dc3545; color: white; }
        .btn-reject:hover { background: #c82333; }
        .btn-back { background: #6c757d; color: white; text-decoration: none; display: inline-block; padding: 10px 20px; border-radius: 4px; }
        .btn-back:hover { background: #5a6268; }
        .expense-category { background: #f0f8ff; padding: 8px; border-left: 3px solid #28a745; }
        .total-row { background: #d4edda; font-weight: bold; font-size: 16px; }
        .hod-approval { background: #d4edda; border-left: 4px solid #28a745; padding: 15px; margin: 20px 0; }
        .designation-badges { display: flex; gap: 10px; flex-wrap: wrap; }
        .badge { background: #28a745; color: white; padding: 5px 10px; border-radius: 4px; font-size: 12px; }
        .badge-location { padding: 5px 10px; border-radius: 4px; font-size: 12px; font-weight: bold; }
        .badge-india { background: #28a745; color: white; }
        .badge-abroad { background: #6f42c1; color: white; }
        .attachment-link { color: #007bff; text-decoration: none; }
        .attachment-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <h2>
        <?php 
        if ($type === 'f5') {
            echo 'F-5 Conference Reimbursement Application - Final Approval (Assistant Registrar)';
        } else {
            echo 'F-4 Reimbursement Application - Final Approval (Assistant Registrar)';
        }
        ?>
    </h2>
    
    <p><a href="accounts_ar_dashboard.php" class="btn-back">⬅ Back to Dashboard</a></p>

    <?php if ($type === 'f5'): ?>
        <!-- F-5 CONFERENCE REIMBURSEMENT APPLICATION -->
        
        <!-- Faculty Details -->
        <h3>Faculty Information</h3>
        <table>
            <tr><th>Reference Number</th><td><strong><?= htmlspecialchars($app['ref_number']); ?></strong></td></tr>
            <tr><th>Employee Code</th><td><?= htmlspecialchars($app['employee_code']); ?></td></tr>
            <tr><th>Faculty Name</th><td><?= htmlspecialchars($app['faculty_name']); ?></td></tr>
            <tr><th>Designation</th><td><?= htmlspecialchars($app['designation']); ?></td></tr>
            <tr><th>Pay Level</th><td><?= htmlspecialchars($app['pay_level']); ?></td></tr>
            <tr><th>Department</th><td><?= htmlspecialchars($app['department']); ?></td></tr>
            <tr><th>Submission Date</th><td><?= date('d-M-Y H:i', strtotime($app['created_at'])); ?></td></tr>
        </table>

        <!-- HOD Approval Details -->
        <div class="hod-approval">
            <h4 style="margin-top:0;">✓ HOD Approval</h4>
            <p><strong>Status:</strong> <span style="color: #28a745;">APPROVED</span></p>
            <p><strong>Approved By:</strong> <?= htmlspecialchars($app['hod_approved_by'] ?? 'N/A'); ?></p>
            <?php if ($app['hod_approved_at']): ?>
                <p><strong>Approval Date:</strong> <?= date('d-M-Y H:i', strtotime($app['hod_approved_at'])); ?></p>
            <?php endif; ?>
            <?php if ($app['hod_comments']): ?>
                <p><strong>HOD Remarks:</strong><br><?= nl2br(htmlspecialchars($app['hod_comments'])); ?></p>
            <?php endif; ?>
        </div>

        <!-- Activity Details -->
        <h3>Activity Details</h3>
        <table>
            <tr><th>Activity Nature</th><td><span class="badge"><?= htmlspecialchars($app['activity_nature']); ?></span></td></tr>
            <tr><th>Activity Name</th><td><?= htmlspecialchars($app['activity_name']); ?></td></tr>
            <tr>
                <th>Activity Dates</th>
                <td>
                    <strong>From:</strong> <?= date('d-M-Y', strtotime($app['activity_start_date'])); ?><br>
                    <strong>To:</strong> <?= date('d-M-Y', strtotime($app['activity_end_date'])); ?><br>
                    <strong>Duration:</strong> <?php
                        $start = new DateTime($app['activity_start_date']);
                        $end = new DateTime($app['activity_end_date']);
                        $interval = $start->diff($end);
                        echo ($interval->days + 1) . ' day(s)';
                    ?>
                </td>
            </tr>
            <tr><th>Venue</th><td><?= htmlspecialchars($app['activity_venue']); ?></td></tr>
            <tr>
                <th>Location Type</th>
                <td>
                    <span class="badge-location badge-<?= strtolower($app['location_type']); ?>">
                        <?= htmlspecialchars($app['location_type']); ?>
                    </span>
                </td>
            </tr>
        </table>

        <!-- Expenditure Details -->
        <h3>Details of Expenditure</h3>
        <table>
            <tr class="section-header"><th>Expense Category</th><th>Amount (₹)</th></tr>
            <tr class="expense-category">
                <td>(a) Registration fee including transaction charges<br>
                    <small style="color: #666;">अंतरण शुल्क सहित पंजीयन शुल्क</small>
                </td>
                <td>₹<?= number_format($app['expense_registration'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(b) Visa Fee (if applicable) and expenses for collection of visa<br>
                    <small style="color: #666;">वीजा शुल्क (यदि लागू हो) व वीजा संग्रह हेतु व्यय</small>
                </td>
                <td>₹<?= number_format($app['expense_visa'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(c) Insurance fee (if applicable)<br>
                    <small style="color: #666;">बीमा शुल्क (यदि लागू हो)</small>
                </td>
                <td>₹<?= number_format($app['expense_insurance'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(d) TA (Air Fare)<br>
                    <small style="color: #666;">टीए (विमान/हवाई यात्रा)</small>
                </td>
                <td>₹<?= number_format($app['expense_air_fare'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(e) TA (Local Travel)<br>
                    <small style="color: #666;">टीए (स्थानीय यात्रा)</small>
                </td>
                <td>₹<?= number_format($app['expense_local_travel'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(f) DA per diem<br>
                    <small style="color: #666;">अवधि के लिए डीए/प्रतिदिन</small>
                </td>
                <td>₹<?= number_format($app['expense_da_per_diem'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(g) Boarding & Lodging<br>
                    <small style="color: #666;">भोजन व आवास</small>
                </td>
                <td>₹<?= number_format($app['expense_boarding_lodging'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(h) Any Other expenses<br>
                    <small style="color: #666;">कोई अन्य व्यय</small>
                    <?php if (!empty($app['expense_other_description'])): ?>
                        <br><small style="color: #007bff;"><strong>Description:</strong> <?= htmlspecialchars($app['expense_other_description']); ?></small>
                    <?php endif; ?>
                </td>
                <td>₹<?= number_format($app['expense_other'], 2); ?></td>
            </tr>
            <tr class="total-row">
                <td><strong>TOTAL AMOUNT (कुल - a to h)</strong></td>
                <td><strong>₹<?= number_format($app['total_amount'], 2); ?></strong></td>
            </tr>
        </table>

        <!-- Remarks -->
        <?php if (!empty($app['remarks'])): ?>
        <h3>Faculty Remarks / टिप्पणी</h3>
        <table>
            <tr>
                <td><?= nl2br(htmlspecialchars($app['remarks'])); ?></td>
            </tr>
        </table>
        <?php endif; ?>

        <!-- Attachments -->
        <h3>Supporting Documents</h3>
        <table>
            <tr class="section-header"><th>Document Type</th><th>File Name</th><th>Description</th><th>Size</th></tr>
            <?php if ($attachments->num_rows > 0): ?>
                <?php while ($attach = $attachments->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($attach['attachment_type']); ?></td>
                        <td>
                            <a href="<?= htmlspecialchars($attach['file_path']); ?>" 
                               target="_blank" class="attachment-link">
                                📎 <?= htmlspecialchars($attach['file_name']); ?>
                            </a>
                        </td>
                        <td><?= htmlspecialchars($attach['description'] ?? 'N/A'); ?></td>
                        <td><?= round($attach['file_size'] / 1024, 2); ?> KB</td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr><td colspan="4"><em>No attachments uploaded</em></td></tr>
            <?php endif; ?>
        </table>

        <!-- AR Final Approval Action for F-5 -->
        <div class="button-group">
            <h3 style="margin-top: 0;">Assistant Registrar - Final Approval Decision</h3>
            <form action="../controllers/ARF4Controller.php" method="POST">
                <input type="hidden" name="application_id" value="<?= $app['application_id']; ?>">
                
                <label><strong>Sanctioned Amount (₹):</strong></label><br>
                <input type="number" name="sanctioned_amount" step="0.01" min="0" 
                       value="<?= $app['total_amount']; ?>" 
                       style="width: 300px; padding: 8px; margin-bottom: 15px;" required>
                <br>
                
                <label><strong>AR Remarks / Comments:</strong></label><br>
                <textarea name="ar_remarks" rows="5" required placeholder="Enter your final approval remarks..."></textarea>
                <br><br>
                
                <button type="submit" name="action" value="approve" class="btn-approve">
                    ✅ GRANT FINAL APPROVAL
                </button>
                
                <button type="submit" name="action" value="reject" class="btn-reject">
                    ❌ REJECT APPLICATION
                </button>
            </form>
        </div>

    <?php else: ?>
        <!-- F-4 REIMBURSEMENT APPLICATION -->
        
        <!-- Faculty Details -->
        <h3>Faculty Information</h3>
        <table>
            <tr><th>Application Number</th><td><strong><?= htmlspecialchars($app['ref_number']); ?></strong></td></tr>
            <tr><th>Employee Code</th><td><?= htmlspecialchars($app['employee_code']); ?></td></tr>
            <tr><th>Faculty Name</th><td><?= htmlspecialchars($app['faculty_name']); ?></td></tr>
            <tr>
                <th>Designation</th>
                <td>
                    <div class="designation-badges">
                        <?php if ($app['designation_hag']): ?><span class="badge">Professor (HAG)</span><?php endif; ?>
                        <?php if ($app['designation_professor']): ?><span class="badge">Professor</span><?php endif; ?>
                        <?php if ($app['designation_associate_professor']): ?><span class="badge">Associate Professor</span><?php endif; ?>
                        <?php if ($app['designation_assistant_professor']): ?><span class="badge">Assistant Professor</span><?php endif; ?>
                    </div>
                </td>
            </tr>
            <tr><th>Pay Level</th><td><?= htmlspecialchars($app['pay_level']); ?></td></tr>
            <tr><th>Department</th><td><?= htmlspecialchars($app['department']); ?></td></tr>
            <tr><th>Submission Date</th><td><?= date('d-M-Y', strtotime($app['submission_date'])); ?></td></tr>
        </table>

        <!-- HOD Approval Details -->
        <div class="hod-approval">
            <h4 style="margin-top:0;">✓ HOD Approval</h4>
            <p><strong>Status:</strong> <span style="color: #28a745;">APPROVED</span></p>
            <p><strong>Approved By:</strong> <?= htmlspecialchars($app['hod_approved_by']); ?></p>
            <p><strong>Approval Date:</strong> <?= date('d-M-Y H:i', strtotime($app['hod_approval_date'])); ?></p>
            <p><strong>HOD Remarks:</strong><br><?= nl2br(htmlspecialchars($app['hod_remarks'])); ?></p>
        </div>

        <!-- Professional Memberships -->
        <h3>Professional Membership Details</h3>
        <table>
            <tr class="section-header"><th>Professional Body Name</th><th>Amount (₹)</th><th>Type</th></tr>
            <?php if ($memberships->num_rows > 0): ?>
                <?php 
                $membership_total = 0;
                while ($row = $memberships->fetch_assoc()): 
                    $membership_total += $row['membership_amount'];
                ?>
                    <tr>
                        <td><?= htmlspecialchars($row['professional_body_name']); ?></td>
                        <td>₹<?= number_format($row['membership_amount'], 2); ?></td>
                        <td><?= htmlspecialchars($row['membership_type']); ?></td>
                    </tr>
                <?php endwhile; ?>
                <tr class="total-row">
                    <td colspan="2" style="text-align: right;"><strong>Membership Total:</strong></td>
                    <td><strong>₹<?= number_format($membership_total, 2); ?></strong></td>
                </tr>
            <?php else: ?>
                <tr><td colspan="3"><em>No professional memberships listed.</em></td></tr>
            <?php endif; ?>
        </table>

        <!-- Expense Details -->
        <h3>Details of Expenses</h3>
        <table>
            <tr class="section-header"><th>Expense Category</th><th>Amount (₹)</th></tr>
            <tr class="expense-category">
                <td>(a) Books - पुस्तकें</td>
                <td>₹<?= number_format($app['expense_books'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(b) Stationary Items - स्टेशनरी सामग्री</td>
                <td>₹<?= number_format($app['expense_stationary'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(c) Patent - पेटेंट</td>
                <td>₹<?= number_format($app['expense_patent'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(d) Computer Consumables (External Storage, Cartridges)</td>
                <td>₹<?= number_format($app['expense_computer_consumables'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(e) Consumables (Chemicals, Laboratory Glassware)</td>
                <td>₹<?= number_format($app['expense_consumables'], 2); ?></td>
            </tr>
            <tr class="expense-category">
                <td>(f) Charges for Synthesis & Analysis of Samples</td>
                <td>₹<?= number_format($app['expense_synthesis_analysis'], 2); ?></td>
            </tr>
            <tr class="total-row">
                <td><strong>TOTAL AMOUNT</strong></td>
                <td><strong>₹<?= number_format($app['total_amount'], 2); ?></strong></td>
            </tr>
        </table>

        <!-- Remarks -->
        <?php if (!empty($app['remarks'])): ?>
        <h3>Faculty Remarks</h3>
        <table>
            <tr>
                <td><?= nl2br(htmlspecialchars($app['remarks'])); ?></td>
            </tr>
        </table>
        <?php endif; ?>

        <!-- Attachments -->
        <h3>Supporting Documents</h3>
        <table>
            <tr class="section-header"><th>Document Type</th><th>File Name</th><th>Description</th><th>Size</th></tr>
            <?php if ($attachments->num_rows > 0): ?>
                <?php while ($attach = $attachments->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($attach['attachment_type']); ?></td>
                        <td>
                            <a href="<?= htmlspecialchars($attach['file_path']); ?>" 
                               target="_blank" class="attachment-link">
                                📎 <?= htmlspecialchars($attach['file_name']); ?>
                            </a>
                        </td>
                        <td><?= htmlspecialchars($attach['description'] ?? 'N/A'); ?></td>
                        <td><?= round($attach['file_size'] / 1024, 2); ?> KB</td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr><td colspan="4"><em>No attachments uploaded</em></td></tr>
            <?php endif; ?>
        </table>

        <!-- AR Final Approval Action for F-4 -->
        <div class="button-group">
            <h3 style="margin-top: 0;">Assistant Registrar - Final Approval Decision</h3>
            <form action="../controllers/ARF3Controller.php" method="POST">
                <input type="hidden" name="application_id" value="<?= $app['application_id']; ?>">
                
                <label><strong>Sanctioned Amount (₹):</strong></label><br>
                <input type="number" name="sanctioned_amount" step="0.01" min="0" 
                       value="<?= $app['total_amount']; ?>" 
                       style="width: 300px; padding: 8px; margin-bottom: 15px;" required>
                <br>
                
                <label><strong>AR Remarks / Comments:</strong></label><br>
                <textarea name="ar_remarks" rows="5" required placeholder="Enter your final approval remarks..."></textarea>
                <br><br>
                
                <button type="submit" name="action" value="approve" class="btn-approve">
                    ✅ GRANT FINAL APPROVAL
                </button>
                
                <button type="submit" name="action" value="reject" class="btn-reject">
                    ❌ REJECT APPLICATION
                </button>
            </form>
        </div>
    <?php endif; ?>

    <p><a href="accounts_ar_dashboard.php" class="btn-back">⬅ Back to Dashboard</a></p>
</div>

</body>
</html>

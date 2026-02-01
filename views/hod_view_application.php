<?php
session_start();
include_once '../config/db.php';

// Redirect if not HOD
if ($_SESSION['role'] !== 'hod') {
    header("Location: login.php");
    exit();
}

$app_id = $_GET['application_id'] ?? null;
$type = $_GET['type'] ?? 'form1'; // Default to form1 if not specified

if (!$app_id) {
    die("Invalid application ID.");
}

// Determine which form to load based on type
if ($type === 'event') {
    // CPDA Event Application
    $stmt = $conn->prepare("SELECT * FROM cpda_event_applications WHERE application_id = ?");
    $stmt->bind_param("i", $app_id);
    $stmt->execute();
    $app = $stmt->get_result()->fetch_assoc();
    
    if (!$app) {
        die("Event application not found.");
    }
    
    // Verify department access
    if ($app['department'] !== $_SESSION['department']) {
        die("Unauthorized access to this application.");
    }
    
    // Fetch attachments for event application
    $stmt2 = $conn->prepare("SELECT * FROM cpda_event_attachments WHERE application_id = ?");
    $stmt2->bind_param("i", $app_id);
    $stmt2->execute();
    $attachments = $stmt2->get_result();
    
} elseif ($type === 'f4') {
    // F-4 Reimbursement Application
    $stmt = $conn->prepare("SELECT * FROM f4_reimbursement_applications WHERE application_id = ?");
    $stmt->bind_param("i", $app_id);
    $stmt->execute();
    $app = $stmt->get_result()->fetch_assoc();
    
    if (!$app) {
        die("F-4 reimbursement application not found.");
    }
    
    // Verify department access
    if ($app['department'] !== $_SESSION['department']) {
        die("Unauthorized access to this application.");
    }
    
    // Fetch professional memberships
    $stmt2 = $conn->prepare("SELECT * FROM f4_professional_memberships WHERE application_id = ?");
    $stmt2->bind_param("i", $app_id);
    $stmt2->execute();
    $memberships = $stmt2->get_result();
    
    // Fetch attachments
    $stmt3 = $conn->prepare("SELECT * FROM f4_reimbursement_attachments WHERE application_id = ?");
    $stmt3->bind_param("i", $app_id);
    $stmt3->execute();
    $attachments = $stmt3->get_result();
    
} elseif ($type === 'f5') {
    // F-5 Conference Reimbursement Application
    $stmt = $conn->prepare("SELECT * FROM f5_conference_reimbursements WHERE application_id = ?");
    $stmt->bind_param("i", $app_id);
    $stmt->execute();
    $app = $stmt->get_result()->fetch_assoc();
    
    if (!$app) {
        die("F-5 conference reimbursement application not found.");
    }
    
    // Verify department access
    if ($app['department'] !== $_SESSION['department']) {
        die("Unauthorized access to this application.");
    }
    
    // Fetch attachments
    $stmt2 = $conn->prepare("SELECT * FROM f5_attachments WHERE reimbursement_id = ?");
    $stmt2->bind_param("i", $app_id);
    $stmt2->execute();
    $attachments = $stmt2->get_result();
    
} else {
    // CPDA Form 1 (Purchase/Membership)
    $stmt = $conn->prepare("SELECT * FROM cpda_applications WHERE application_id = ?");
    $stmt->bind_param("i", $app_id);
    $stmt->execute();
    $app = $stmt->get_result()->fetch_assoc();
    
    if (!$app) {
        die("Application not found.");
    }
    
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
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['application_id']) && isset($_POST['hod_remarks']) && isset($_POST['action'])) {
    $ref_number_for_message = null;
    try {
        $app_id_for_message = (int)$_POST['application_id'];
        $hod_remarks_for_message = trim($_POST['hod_remarks']);
        $action_for_message = $_POST['action'];
        $sender_employee_code = $_SESSION['employee_code'];
        
        // Get ref_number of this application to link message
        $stmt_ref = $conn->prepare("SELECT ref_number FROM (SELECT application_id, ref_number FROM cpda_applications UNION ALL SELECT application_id, ref_number FROM cpda_event_applications UNION ALL SELECT application_id, ref_number FROM f4_reimbursement_applications UNION ALL SELECT application_id, ref_number FROM f5_conference_reimbursements) AS combined WHERE application_id = ?");
        $stmt_ref->bind_param("i", $app_id_for_message);
        $stmt_ref->execute();
        $res_ref = $stmt_ref->get_result();
        if ($res_ref->num_rows === 0) {
            throw new Exception("Cannot find reference number for this application");
        }
        $row_ref = $res_ref->fetch_assoc();
        $ref_number_for_message = $row_ref['ref_number'];
        $stmt_ref->close();
        
        // Determine next message_sequence number
        $stmt_seq = $conn->prepare("SELECT IFNULL(MAX(message_sequence), 0) + 1 AS next_seq FROM application_timeline_messages WHERE ref_number = ?");
        $stmt_seq->bind_param("s", $ref_number_for_message);
        $stmt_seq->execute();
        $res_seq = $stmt_seq->get_result();
        $seq_row = $res_seq->fetch_assoc();
        $next_seq = $seq_row['next_seq'];
        $stmt_seq->close();
        
        // Compose message to insert
        $message_to_insert = ($action_for_message === 'approve' ? "[APPROVED] " : "[REJECTED] ") . $hod_remarks_for_message;
        
        // Insert message
        $stmt_msg = $conn->prepare("INSERT INTO application_timeline_messages (ref_number, message_sequence, message, sender_identifier, message_time) VALUES (?, ?, ?, ?, NOW())");
        $stmt_msg->bind_param("siss", $ref_number_for_message, $next_seq, $message_to_insert, $sender_employee_code);
        if (!$stmt_msg->execute()) {
            throw new Exception("Failed to insert timeline message: " . $stmt_msg->error);
        }
        $stmt_msg->close();
        
        // You can redirect after submission or continue
    } catch (Exception $e) {
        // Handle exceptions/logging as needed
        error_log("Timeline message insert failed: " . $e->getMessage());
    }
}
$last_message = null;
if (!empty($app['ref_number'])) {
    $stmt_last_msg = $conn->prepare("SELECT message, sender_identifier, message_time FROM application_timeline_messages WHERE ref_number = ? ORDER BY message_sequence DESC LIMIT 1");
    $stmt_last_msg->bind_param("s", $app['ref_number']);
    $stmt_last_msg->execute();
    $res_last_msg = $stmt_last_msg->get_result();
    if ($res_last_msg->num_rows > 0) {
        $last_message = $res_last_msg->fetch_assoc();
    }
    $stmt_last_msg->close();
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOD Review Application</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 { 
            color: #333;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
        }
        h3 { 
            color: #555;
            margin-top: 25px;
            background: #e3f2fd;
            padding: 10px;
            border-left: 4px solid #007bff;
        }
        table { 
            border-collapse: collapse; 
            width: 100%; 
            margin-bottom: 25px; 
            background: white;
        }
        table, th, td { 
            border: 1px solid #ddd; 
        }
        th { 
            background-color: #f0f0f0;
            padding: 10px; 
            text-align: left;
            width: 250px;
            font-weight: bold;
        }
        td { 
            padding: 10px; 
        }
        .section-header { 
            background: #007bff;
            color: white;
            padding: 12px; 
            font-weight: bold;
            font-size: 16px;
        }
        textarea { 
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-family: Arial, sans-serif;
        }
        .button-group {
            margin-top: 30px;
            padding: 20px;
            background: #f9f9f9;
            border: 2px solid #ddd;
            border-radius: 5px;
        }
        button { 
            padding: 12px 25px; 
            margin: 5px; 
            cursor: pointer;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
        }
        .btn-approve {
            background: #28a745;
            color: white;
        }
        .btn-approve:hover {
            background: #218838;
        }
        .btn-reject {
            background: #dc3545;
            color: white;
        }
        .btn-reject:hover {
            background: #c82333;
        }
        .btn-back {
            background: #6c757d;
            color: white;
            text-decoration: none;
            display: inline-block;
            padding: 10px 20px;
            border-radius: 4px;
        }
        .btn-back:hover {
            background: #5a6268;
        }
        .expense-row {
            background: #fffde7;
        }
        .total-row {
            background: #fff3cd;
            font-weight: bold;
            font-size: 16px;
        }
        .attachment-link {
            color: #007bff;
            text-decoration: none;
        }
        .attachment-link:hover {
            text-decoration: underline;
        }
        .designation-badges {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .badge {
            background: #007bff;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
        }
        .badge-location {
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        .badge-india {
            background: #28a745;
            color: white;
        }
        .badge-abroad {
            background: #6f42c1;
            color: white;
        }
        .expense-category {
            background: #f0f8ff;
            padding: 8px;
            border-left: 3px solid #007bff;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>
        <?php 
        if ($type === 'event') {
            echo 'CPDA Event Application Review';
        } elseif ($type === 'f4') {
            echo 'F-4 Reimbursement Application Review';
        } elseif ($type === 'f5') {
            echo 'F-5 Conference/Workshop Reimbursement Application Review';
        } else {
            echo 'CPDA Form 1 Application Review';
        }
        ?> – HOD Approval
    </h2>
    
    <p><a href="hod_dashboard.php" class="btn-back">⬅ Back to Dashboard</a></p>
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
        <h3>Remarks / टिप्पणी</h3>
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
        <?php if ($last_message): ?>
        <div style="background:#e7f0ff; border:1px solid #007bff; padding:15px; margin-bottom:20px; border-radius:5px;">
            <strong>Last Message:</strong> <?= htmlspecialchars($last_message['message']); ?><br>
            <small><em>Sent by Employee ID: <?= htmlspecialchars($last_message['sender_identifier']); ?> on <?= $last_message['message_time']; ?></em></small>
        </div>
        <?php endif; ?>

        <!-- HOD Action for F-5 Form -->
        <div class="button-group">
            <h3 style="margin-top: 0;">HOD Recommendation / Action</h3>
            <form action="../controllers/HODF4Controller.php" method="POST">
                <input type="hidden" name="application_id" value="<?= $app['application_id']; ?>">
                
                <label><strong>HOD Comments / Remarks:</strong></label><br>
                <textarea name="hod_remarks" rows="5" required placeholder="Enter your comments or recommendations here..."></textarea>
                <br><br>
                
                <button type="submit" name="action" value="approve" class="btn-approve">
                    ✅ APPROVE & RECOMMEND
                </button>
                
                <button type="submit" name="action" value="reject" class="btn-reject">
                    ❌ REJECT APPLICATION
                </button>
            </form>
        </div>

    <?php elseif ($type === 'f4'): ?>
        <!-- F-4 REIMBURSEMENT APPLICATION (Keep existing code) -->
        
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
        <h3>Remarks</h3>
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
        <?php if ($last_message): ?>
        <div style="background:#e7f0ff; border:1px solid #007bff; padding:15px; margin-bottom:20px; border-radius:5px;">
            <strong>Last Message:</strong> <?= htmlspecialchars($last_message['message']); ?><br>
            <small><em>Sent by Employee ID: <?= htmlspecialchars($last_message['sender_identifier']); ?> on <?= $last_message['message_time']; ?></em></small>
        </div>
        <?php endif; ?>

        <!-- HOD Action for F-4 Form -->
        <div class="button-group">
            <h3 style="margin-top: 0;">HOD Recommendation / Action</h3>
            <form action="../controllers/HODF3Controller.php" method="POST">
                <input type="hidden" name="application_id" value="<?= $app['application_id']; ?>">
                
                <label><strong>HOD Comments / Remarks:</strong></label><br>
                <textarea name="hod_remarks" rows="5" required placeholder="Enter your comments or recommendations here..."></textarea>
                <br><br>
                
                <button type="submit" name="action" value="approve" class="btn-approve">
                    ✅ APPROVE & RECOMMEND
                </button>
                
                <button type="submit" name="action" value="reject" class="btn-reject">
                    ❌ REJECT APPLICATION
                </button>
            </form>
        </div>

    <?php elseif ($type === 'event'): ?>
        <!-- EVENT APPLICATION FORM (Keep existing code) -->
        
        <!-- Applicant Details -->
        <h3>Section 1-6: Faculty Details</h3>
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
            <tr><th>Date of Joining</th><td><?= date('d-M-Y', strtotime($app['date_of_joining'])); ?></td></tr>
        </table>

        <!-- Event Details -->
        <h3>Section 7-11: Event Details</h3>
        <table>
            <tr><th>Nature of Event</th><td><?= htmlspecialchars($app['nature_of_event']); ?></td></tr>
            <tr><th>Title of Event</th><td><?= htmlspecialchars($app['title_of_event']); ?></td></tr>
            <tr><th>Period of Event</th><td><?= htmlspecialchars($app['period_of_event']); ?></td></tr>
            <tr><th>Working Days Involved</th><td><?= htmlspecialchars($app['working_days_involved']); ?> days</td></tr>
            <tr><th>Venue of Event</th><td><?= htmlspecialchars($app['venue_of_event']); ?></td></tr>
            <tr><th>Location</th><td><?= htmlspecialchars($app['location']); ?></td></tr>
        </table>

        <!-- Paper Details -->
        <h3>Section 12: Paper Details</h3>
        <table>
            <tr><th>Paper Title</th><td><?= $app['paper_title'] ? htmlspecialchars($app['paper_title']) : '<em>Not provided</em>'; ?></td></tr>
            <tr><th>Authors</th><td><?= $app['paper_authors'] ? nl2br(htmlspecialchars($app['paper_authors'])) : '<em>Not provided</em>'; ?></td></tr>
            <tr><th>No Objection Details</th><td><?= $app['no_objection_details'] ? nl2br(htmlspecialchars($app['no_objection_details'])) : '<em>Not provided</em>'; ?></td></tr>
        </table>

        <!-- Expense Details -->
        <h3>Section 13: Details of Expenses</h3>
        <table>
            <tr class="section-header"><th colspan="2">Expense Breakdown</th></tr>
            <tr class="expense-row"><th>a) Registration Fee (including transaction charges)</th><td>₹<?= number_format($app['expense_registration_fee'], 2); ?></td></tr>
            <tr class="expense-row"><th>b) Visa Fee (if applicable) and collection expenses</th><td>₹<?= number_format($app['expense_visa_fee'], 2); ?></td></tr>
            <tr class="expense-row"><th>c) Insurance Fee (if applicable)</th><td>₹<?= number_format($app['expense_insurance_fee'], 2); ?></td></tr>
            <tr class="expense-row"><th>d) TA (Air Fare)</th><td>₹<?= number_format($app['expense_air_fare'], 2); ?></td></tr>
            <tr class="expense-row"><th>e) TA (Local Travel)</th><td>₹<?= number_format($app['expense_local_travel'], 2); ?></td></tr>
            <tr class="expense-row"><th>f) DA per diem</th><td>₹<?= number_format($app['expense_da_per_diem'], 2); ?></td></tr>
            <tr class="expense-row"><th>g) Boarding & Lodging as per entitlement</th><td>₹<?= number_format($app['expense_boarding_lodging'], 2); ?></td></tr>
            <tr class="expense-row">
                <th>h) Other Expenses</th>
                <td>
                    ₹<?= number_format($app['expense_other_amount'], 2); ?>
                    <?php if ($app['expense_other_details']): ?>
                        <br><small><em><?= nl2br(htmlspecialchars($app['expense_other_details'])); ?></em></small>
                    <?php endif; ?>
                </td>
            </tr>
            <tr class="total-row"><th>TOTAL (a to h)</th><td>₹<?= number_format($app['expense_total'], 2); ?></td></tr>
        </table>

        <!-- Holiday Period -->
        <h3>Section 14: Event During Holidays/Vacations</h3>
        <table>
            <tr>
                <th>Does event fall during holidays?</th>
                <td><?= htmlspecialchars($app['event_during_holidays']); ?></td>
            </tr>
        </table>

        <!-- Previous Abroad Participation -->
        <h3>Section 15: Previous Abroad Participation (Current CPDA Block)</h3>
        <table>
            <tr>
                <th>Attended programme abroad in current block?</th>
                <td><?= htmlspecialchars($app['attended_abroad_current_block']); ?></td>
            </tr>
            <?php if ($app['attended_abroad_current_block'] === 'YES'): ?>
                <tr><th>Previous Event Name(s)</th><td><?= nl2br(htmlspecialchars($app['previous_event_name'])); ?></td></tr>
                <tr><th>Previous Event Date(s)</th><td><?= htmlspecialchars($app['previous_event_dates']); ?></td></tr>
                <tr><th>Previous Event Venue(s)</th><td><?= htmlspecialchars($app['previous_event_venues']); ?></td></tr>
            <?php endif; ?>
        </table>

        <!-- Attachments -->
        <h3>Attachments</h3>
        <table>
            <tr class="section-header"><th>Attachment Type</th><th>File</th></tr>
            <?php if ($attachments->num_rows > 0): ?>
                <?php while ($attach = $attachments->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($attach['attachment_type']); ?></td>
                        <td>
                            <a href="../uploads/cpda_events/<?= htmlspecialchars($attach['file_path']); ?>" 
                               target="_blank" class="attachment-link">
                                📎 <?= htmlspecialchars($attach['file_name']); ?>
                            </a>
                            <small>(<?= round($attach['file_size'] / 1024, 2); ?> KB)</small>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr><td colspan="2"><em>No attachments uploaded</em></td></tr>
            <?php endif; ?>
        </table>
        <?php if ($last_message): ?>
        <div style="background:#e7f0ff; border:1px solid #007bff; padding:15px; margin-bottom:20px; border-radius:5px;">
            <strong>Last Message:</strong> <?= htmlspecialchars($last_message['message']); ?><br>
            <small><em>Sent by Employee ID: <?= htmlspecialchars($last_message['sender_identifier']); ?> on <?= $last_message['message_time']; ?></em></small>
        </div>
        <?php endif; ?>

        <!-- HOD Action for Event Form -->
        <div class="button-group">
            <h3 style="margin-top: 0;">HOD Recommendation / Action</h3>
            <form action="../controllers/HODEventController.php" method="POST">
                <input type="hidden" name="application_id" value="<?= $app['application_id']; ?>">
                
                <label><strong>HOD Comments / Remarks:</strong></label><br>
                <textarea name="hod_remarks" rows="5" required placeholder="Enter your comments or recommendations here..."></textarea>
                <br><br>
                
                <button type="submit" name="action" value="approve" class="btn-approve">
                    ✅ APPROVE & RECOMMEND
                </button>
                
                <button type="submit" name="action" value="reject" class="btn-reject">
                    ❌ REJECT APPLICATION
                </button>
            </form>
        </div>

    <?php else: ?>
        <!-- FORM 1 APPLICATION (Purchase/Membership) - Keep existing code -->
        
        <h3>Applicant Details</h3>
        <table>
            <tr><th>Employee Code</th><td><?= htmlspecialchars($app['employee_code']); ?></td></tr>
            <tr><th>Name</th><td><?= htmlspecialchars($app['faculty_name']); ?></td></tr>
            <tr><th>Email</th><td><?= htmlspecialchars($app['email']); ?></td></tr>
            <tr><th>Mobile</th><td><?= htmlspecialchars($app['mobile_number']); ?></td></tr>
            <tr><th>Designation</th><td><?= htmlspecialchars($app['designation']); ?></td></tr>
            <tr><th>Department</th><td><?= htmlspecialchars($app['department']); ?></td></tr>
            <tr><th>Pay Level</th><td><?= htmlspecialchars($app['pay_level']); ?></td></tr>
            <tr><th>Date of Joining</th><td><?= htmlspecialchars($app['date_of_joining']); ?></td></tr>
            
        </table>

        <h3>Purchase Details</h3>
        <table>
            <tr><th>Purpose of Purchase</th><td><?= nl2br(htmlspecialchars($app['purpose_of_purchase'])); ?></td></tr>
            <tr><th>Technical Specification / Source</th><td><?= nl2br(htmlspecialchars($app['technical_specification'])); ?></td></tr>
            <tr><th>Remarks</th><td><?= nl2br(htmlspecialchars($app['remarks'])); ?></td></tr>
        </table>

        <h3>Professional Memberships</h3>
        <table>
            <tr class="section-header"><th>Name of Professional Body</th><th>Amount</th><th>Type</th></tr>
            <?php if ($memberships->num_rows > 0): ?>
                <?php while ($row = $memberships->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['professional_body_name']); ?></td>
                        <td>₹<?= number_format($row['amount'], 2); ?></td>
                        <td><?= htmlspecialchars($row['membership_type']); ?></td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr><td colspan="3"><em>No memberships listed.</em></td></tr>
            <?php endif; ?>
        </table>

        <h3>Consumable / Item Details</h3>
        <table>
            <tr class="section-header"><th>Serial No.</th><th>Article Name</th><th>Amount</th><th>Category</th></tr>
            <?php if ($items->num_rows > 0): ?>
                <?php while ($row = $items->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['serial_number']); ?></td>
                        <td><?= htmlspecialchars($row['article_name']); ?></td>
                        <td>₹<?= number_format($row['amount'], 2); ?></td>
                        <td><?= htmlspecialchars($row['item_category']); ?></td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr><td colspan="4"><em>No consumable items listed.</em></td></tr>
            <?php endif; ?>
        </table>
        <?php if ($last_message): ?>
        <div style="background:#e7f0ff; border:1px solid #007bff; padding:15px; margin-bottom:20px; border-radius:5px;">
            <strong>Last Message:</strong> <?= htmlspecialchars($last_message['message']); ?><br>
            <small><em>Sent by Employee ID: <?= htmlspecialchars($last_message['sender_identifier']); ?> on <?= $last_message['message_time']; ?></em></small>
        </div>
        <?php endif; ?>

        <!-- HOD Action for Form 1 -->
        <div class="button-group">
            <h3 style="margin-top: 0;">HOD Recommendation</h3>
            <form action="../controllers/HODController.php" method="POST">
                <input type="hidden" name="application_id" value="<?= $app['application_id']; ?>">
                
                <label><strong>Comments:</strong></label><br>
                <textarea name="comments" rows="5" required placeholder="Enter your comments here..."></textarea>
                <br><br>
                
                <button type="submit" name="action" value="recommend" class="btn-approve">✅ Recommend</button>
                <button type="submit" name="action" value="not_recommend" class="btn-reject">❌ Not Recommend</button>
            </form>
        </div>

    <?php endif; ?>

    <p><a href="hod_dashboard.php" class="btn-back">⬅ Back to Dashboard</a></p>
</div>

</body>
</html>

<?php
session_start();
include_once '../config/db.php';

// Verify user role is DA (Personal Assistant)
if ($_SESSION['role'] !== 'director') {
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
    
    
    
    // Fetch attachments for event application
    $stmt2 = $conn->prepare("SELECT * FROM cpda_event_attachments WHERE application_id = ?");
    $stmt2->bind_param("i", $app_id);
    $stmt2->execute();
    $attachments = $stmt2->get_result();
    
} else {
    // CPDA Form 1 (Purchase/Membership)
    $stmt = $conn->prepare("SELECT * FROM cpda_applications WHERE application_id = ?");
    $stmt->bind_param("i", $app_id);
    $stmt->execute();
    $app = $stmt->get_result()->fetch_assoc();
    $ref_number = $app['ref_number'];
    $stmt_rec = $conn->prepare("SELECT amount_available, amount_recommended, recommendation_date FROM cpda_recommendation WHERE application_ref_number = ? ORDER BY recommendation_id DESC LIMIT 1");
    $stmt_rec->bind_param("s", $ref_number);
    $stmt_rec->execute();
    $rec = $stmt_rec->get_result()->fetch_assoc();
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

/* -----------------------------------------------------------
   FETCH LAST TIMELINE MESSAGE
----------------------------------------------------------- */
$last_message = null;
if (!empty($app['ref_number'])) {

    $stmt_last = $conn->prepare("
        SELECT message, sender_identifier, message_time 
        FROM application_timeline_messages 
        WHERE ref_number = ? 
        ORDER BY message_sequence DESC 
        LIMIT 1
    ");
    $stmt_last->bind_param("s", $app['ref_number']);
    $stmt_last->execute();
    $res_last = $stmt_last->get_result();

    if ($res_last->num_rows > 0) {
        $last_message = $res_last->fetch_assoc();
    }
    $stmt_last->close();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $action = $_POST['action'];
    $user_message = trim($_POST['new_message'] ?? '');
    $ref_number = $app['ref_number'];
    // Limit actions allowed
    $allowed_actions = ['approve', 'not_recommend', 'send_back'];
    if (!in_array($action, $allowed_actions)) {
        die("Invalid action.");
    }

    // Update the status and current_stage as per action
    if ($action === 'approve'&& $type === 'event' && $app['location'] === 'international') {
        $new_status = 'DIRECTOR_APPROVED';
        $new_stage = 'CHAIRMAN_REVIEW';
    } elseif ($action === 'approve') {
        $new_status = 'DIRECTOR_APPROVED';
        $new_stage = 'COMPLETED'; // next step is Associate Dean review
    } elseif ($action === 'not_recommend') {
        $new_status = 'DIRECTOR_REJECTED';
        $new_stage = 'COMPLETED';
    } else if ($action === 'send_back') {
        $new_status = 'DRAFT';
        $new_stage = 'DFW_REVIEW'; // send back to DA for correction
    }

     /* -------------------------------
       Recipient finder logic
       Matches the HOD code pattern
    ------------------------------- */

    $stage_role_map = [
        'DFW_REVIEW' => 'dean_fw',
        'CHAIRMAN_REVIEW' => 'chairman'
    ];

    $next_role = $stage_role_map[$new_stage] ?? null;
    $recipient_employee_code = $app['employee_code'];

    if ($next_role) {
        $stmt_user = $conn->prepare("SELECT employee_code FROM users WHERE role = ? LIMIT 1");
        $stmt_user->bind_param("s", $next_role);
        $stmt_user->execute();
        $u = $stmt_user->get_result()->fetch_assoc();
        if ($u) {
            $recipient_employee_code = $u['employee_code'];
        }
        $stmt_user->close();
    }

    // Update appropriate table and fields
    if ($type === 'form1') {
    $update_sql = "UPDATE cpda_applications SET status = ?, current_stage = ? WHERE application_id = ?";
    $update_stmt = $conn->prepare($update_sql);
    $update_stmt->bind_param("ssi", $new_status, $new_stage, $app_id); // Use $app_id
} else { // event
    $update_sql = "UPDATE cpda_event_applications SET application_status = ?, current_stage = ? WHERE application_id = ?";
    $update_stmt = $conn->prepare($update_sql);
    $update_stmt->bind_param("ssi", $new_status, $new_stage, $app_id); // Use $app_id
}
    
    /* -------------------------------------------------------
       Insert Timeline Message
    ------------------------------------------------------- */
    if (!empty($user_message)) {

        // next sequence
        $stmt_seq = $conn->prepare("
            SELECT IFNULL(MAX(message_sequence), 0) + 1 AS next_seq 
            FROM application_timeline_messages 
            WHERE ref_number = ?
        ");
        $stmt_seq->bind_param("s", $ref_number);
        $stmt_seq->execute();
        $next_seq = $stmt_seq->get_result()->fetch_assoc()['next_seq'];
        $stmt_seq->close();

        // message prefix
        $prefix = match ($action) {
            'approve' => '[Director-RECOMMENDED]',
            'not_recommend' => '[Director-REJECTED]',
            default => '[Director-SEND-BACK]'
        };

        $final_msg = $prefix . ' ' . $user_message;
        $sender_code = $_SESSION['employee_code'];

        // insert timeline
        $stmt_msg = $conn->prepare("
            INSERT INTO application_timeline_messages 
            (ref_number, message_sequence, message, sender_identifier, recipient_identifier, message_time)
            VALUES (?, ?, ?, ?, ?, NOW())
        ");
        $stmt_msg->bind_param("sissi", $ref_number, $next_seq, $final_msg, $sender_code, $recipient_employee_code);
        $stmt_msg->execute();
        $stmt_msg->close();
    }
    
    if ($update_stmt->execute()) {
        header("Location: director_dashboard.php?msg=Action completed successfully");
        exit();
    } else {
        $error = "Failed to update the status. Please try again.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DA Review Application</title>
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
        } else {
            echo 'CPDA Form 1 Application Review';
        }
        ?> – Director
    </h2>
    
    <p><a href="director_dashboard.php" class="btn-back">⬅ Back to Dashboard</a></p>
        <a href="balance_database.php?employee_code=<?= htmlspecialchars($app['employee_code']); ?>" target="_blank">💰 Balance Chart</a><br/>

    <?php if ($type === 'event'): ?>
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
        <h3>Dean's Recommendation</h3>
                <table>
                    <tr>
                        <th>Amount Sanctioned (Rs.)</th>
                        <td><?= number_format($app['sanctioned_amount'], 2); ?></td>
                    </tr>
                </table>
        <?php if ($last_message): ?>
            <div style="padding: 15px; background:#e6f0ff; border: 1px solid #3399ff; border-radius: 5px; margin-bottom: 20px;">
                <strong>Last Message:</strong><br>
                <p><?= nl2br(htmlspecialchars($last_message['message'])); ?></p>
                <small>Sent by Employee ID: <?= htmlspecialchars($last_message['sender_identifier']); ?> at <?= $last_message['message_time']; ?></small>
            </div>
        <?php endif; ?>        
        <!-- director Action for Event Form -->
        <form method="POST" style="max-width: 800px;">
            <label for="action">Take Action:</label>
            <select name="action" id="action" required>
                <option value="">-- Select --</option>
                <option value="approve">approve</option>
                <option value="not_recommend">Not approve</option>
                <option value="send_back">Send Back to da</option>
            </select>
            <br>
            <textarea id="new_message" name="new_message" rows="4" style="width:100%;" required placeholder="Enter your message here..."></textarea><br><br>
            <button type="submit" class="btn-action btn-approve">Submit</button>
        </form>

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
            <tr><th>PDA Block</th><td><?= htmlspecialchars($app['pda_block_start_year']); ?> – <?= htmlspecialchars($app['pda_block_end_year']); ?></td></tr>
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
            <div style="padding: 15px; background:#e6f0ff; border: 1px solid #3399ff; border-radius: 5px; margin-bottom: 20px;">
                <strong>Last Message:</strong><br>
                <p><?= nl2br(htmlspecialchars($last_message['message'])); ?></p>
                <small>Sent by Employee ID: <?= htmlspecialchars($last_message['sender_identifier']); ?> at <?= $last_message['message_time']; ?></small>
            </div>
        <?php endif; ?>
        <!-- director Action for Form 1 -->
        <form method="POST" style="max-width: 800px;">
            <label for="action">Take Action:</label>
            <select name="action" id="action" required>
                <option value="">-- Select --</option>
                <option value="approve">approve</option>
                <option value="not_recommend">Not approve</option>
                <option value="send_back">Send Back to dean</option>
            </select>
            <br>
            <?php if ($rec): ?>
                <h3>Dean's Recommendation</h3>
                <table>
                    <tr>
                        <th>Amount Available (Rs.)</th>
                        <td><?= number_format($rec['amount_available'], 2); ?></td>
                    </tr>
                    <tr>
                        <th>Amount Recommended (Rs.)</th>
                        <td><?= number_format($rec['amount_recommended'], 2); ?></td>
                    </tr>
                    <tr>
                        <th>Recommendation Date</th>
                        <td><?= htmlspecialchars(date('d-M-Y H:i', strtotime($rec['recommendation_date']))); ?></td>
                    </tr>
                </table>
            <?php else: ?>
                <h3>Dean's Recommendation</h3>
                <p><em>No recommendation amount entered by Dean Faculty Welfare.</em></p>
            <?php endif; ?>
            <br>
            <textarea id="new_message" name="new_message" rows="4" style="width:100%;" required  placeholder="Enter your message here..."></textarea><br><br>
            <button type="submit" class="btn-action btn-approve">Submit</button>
        </form>

    <?php endif; ?>

    <p><a href="director_dashboard.php" class="btn-back">⬅ Back to Dashboard</a></p>
</div>

</body>
</html>

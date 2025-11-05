<?php
session_start();
include_once '../config/db.php';

// Redirect if not Assistant Registrar
if (!isset($_SESSION['employee_code']) || $_SESSION['role'] !== 'accounts_ar') {
    header("Location: ../views/login.php");
    exit();
}

// Fetch F-4 Reimbursement Applications pending final approval
$sql_f4 = "SELECT 
            a.application_id,
            a.ref_number,
            a.employee_code,
            a.faculty_name,
            a.department,
            a.total_amount,
            a.submission_date,
            a.application_status,
            a.hod_approval_status,
            a.hod_remarks,
            a.hod_approved_by,
            (SELECT COUNT(*) FROM f4_professional_memberships WHERE application_id = a.application_id) as membership_count,
            (SELECT COUNT(*) FROM f4_reimbursement_attachments WHERE application_id = a.application_id) as attachment_count
        FROM f4_reimbursement_applications a
        WHERE a.application_status = 'HOD_APPROVED'
          AND a.hod_approval_status = 'APPROVED'
        ORDER BY a.submission_date ASC";

$result_f4 = $conn->query($sql_f4);

// Fetch F-5 Conference Reimbursement Applications pending final approval
// CORRECTED: Removed dean_status since it doesn't exist in your table
$sql_f5 = "SELECT 
            f.application_id,
            f.ref_number,
            f.employee_code,
            f.faculty_name,
            f.department,
            f.activity_nature,
            f.activity_name,
            f.activity_start_date,
            f.activity_end_date,
            f.location_type,
            f.total_amount,
            f.created_at,
            f.hod_status,
            f.hod_approved_by,
            f.hod_approved_at,
            f.hod_comments,
            (SELECT COUNT(*) FROM f5_attachments WHERE reimbursement_id = f.application_id) as attachment_count
        FROM f5_conference_reimbursements f
        WHERE f.hod_status = 'APPROVED'
          AND f.accounts_status = 'PENDING'
        ORDER BY f.created_at ASC";

$result_f5 = $conn->query($sql_f5);

// Get statistics
$total_f4_pending = $result_f4->num_rows;
$total_f5_pending = $result_f5->num_rows;
$total_pending = $total_f4_pending + $total_f5_pending;

// Get recently approved/rejected applications from both F-4 and F-5
$sql_recent = "
    SELECT ref_number, faculty_name, total_amount, application_status as status, last_updated, 'F-4' as form_type
    FROM f4_reimbursement_applications 
    WHERE application_status IN ('AR_APPROVED', 'AR_REJECTED')
    UNION ALL
    SELECT ref_number, faculty_name, total_amount, 
           CASE 
               WHEN accounts_status = 'APPROVED' THEN 'AR_APPROVED'
               WHEN accounts_status = 'REJECTED' THEN 'AR_REJECTED'
               ELSE status
           END as status,
           updated_at as last_updated,
           'F-5' as form_type
    FROM f5_conference_reimbursements 
    WHERE accounts_status IN ('APPROVED', 'REJECTED')
    ORDER BY last_updated DESC 
    LIMIT 10";
$result_recent = $conn->query($sql_recent);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assistant Registrar Dashboard</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 { 
            color: #333;
            border-bottom: 3px solid #28a745;
            padding-bottom: 10px;
        }
        h3 {
            color: #555;
            margin-top: 30px;
            background: #d4edda;
            padding: 12px;
            border-left: 4px solid #28a745;
        }
        .header-info {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .stats-container {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            flex: 1;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            color: white;
        }
        .stat-card.primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .stat-card.success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }
        .stat-card.warning {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        .stat-card.info {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        .stat-number {
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .stat-label {
            font-size: 14px;
        }
        table { 
            border-collapse: collapse; 
            width: 100%; 
            margin-top: 15px;
            background: white;
            margin-bottom: 30px;
        }
        table, th, td { 
            border: 1px solid #ddd; 
        }
        th {
            background-color: #28a745;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
        }
        td { 
            padding: 10px; 
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn-view {
            background: #28a745;
            color: white;
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
        }
        .btn-view:hover {
            background: #218838;
        }
        .status-approved {
            color: #28a745;
            font-weight: bold;
        }
        .status-pending {
            color: #ff9800;
            font-weight: bold;
        }
        .no-data {
            text-align: center;
            padding: 30px;
            color: #999;
            font-style: italic;
        }
        .logout-btn {
            float: right;
            background: #dc3545;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
        }
        .logout-btn:hover {
            background: #c82333;
        }
        .badge {
            display: inline-block;
            padding: 3px 8px;
            font-size: 12px;
            border-radius: 3px;
            background: #17a2b8;
            color: white;
        }
        .badge-location {
            padding: 3px 8px;
            font-size: 11px;
            border-radius: 3px;
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
        .badge-form {
            padding: 3px 8px;
            font-size: 11px;
            border-radius: 3px;
            font-weight: bold;
            background: #007bff;
            color: white;
        }
        .section-divider {
            margin: 40px 0;
            border-top: 2px solid #ddd;
        }
    </style>
</head>
<body>

<div class="container">
    <a href="../controllers/logout.php" class="logout-btn">Logout</a>
    <h2>Assistant Registrar Dashboard - Final Approval</h2>
    
    <div class="header-info">
        <strong>Welcome, <?= htmlspecialchars($_SESSION['name']); ?></strong><br>
        <strong>Role:</strong> Assistant Registrar (Final Approval Authority)<br>
        <strong>Employee Code:</strong> <?= htmlspecialchars($_SESSION['employee_code']); ?>
    </div>

    <!-- Summary Statistics -->
    <div class="stats-container">
        <div class="stat-card primary">
            <div class="stat-number"><?= $total_pending; ?></div>
            <div class="stat-label">Total Pending Approvals</div>
        </div>
        <div class="stat-card success">
            <div class="stat-number"><?= $total_f4_pending; ?></div>
            <div class="stat-label">F-4 Reimbursements Pending</div>
        </div>
        <div class="stat-card info">
            <div class="stat-number"><?= $total_f5_pending; ?></div>
            <div class="stat-label">F-5 Conference Pending</div>
        </div>
    </div>

    <!-- F-4 Reimbursement Applications -->
    <h3>💰 F-4 Reimbursement Applications - Final Approval</h3>
    <p style="color: #555; font-size: 14px; margin-top: -15px;">
        <em>These applications have been approved by respective HODs and are awaiting your final approval.</em>
    </p>

    <table>
        <thead>
            <tr>
                <th>Ref No.</th>
                <th>Faculty Name</th>
                <th>Employee Code</th>
                <th>Department</th>
                <th>Memberships</th>
                <th>Attachments</th>
                <th>Total Amount (₹)</th>
                <th>HOD Status</th>
                <th>Submitted On</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result_f4->num_rows > 0): ?>
                <?php while ($row = $result_f4->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['ref_number']); ?></td>
                        <td><?= htmlspecialchars($row['faculty_name']); ?></td>
                        <td><?= htmlspecialchars($row['employee_code']); ?></td>
                        <td><?= htmlspecialchars($row['department']); ?></td>
                        <td>
                            <?php if ($row['membership_count'] > 0): ?>
                                <span class="badge"><?= $row['membership_count']; ?> Membership(s)</span>
                            <?php else: ?>
                                <span style="color: #999;">-</span>
                            <?php endif; ?>
                        </td>
                        <td>
                            <?php if ($row['attachment_count'] > 0): ?>
                                <span class="badge" style="background: #6c757d;"><?= $row['attachment_count']; ?> Files</span>
                            <?php else: ?>
                                <span style="color: #999;">-</span>
                            <?php endif; ?>
                        </td>
                        <td style="text-align: right;">₹<?= number_format($row['total_amount'], 2); ?></td>
                        <td class="status-approved">✓ <?= htmlspecialchars($row['hod_approval_status']); ?></td>
                        <td><?= date('d-M-Y', strtotime($row['submission_date'])); ?></td>
                        <td>
                            <a href="ar_view_application.php?application_id=<?= $row['application_id']; ?>&type=f4" class="btn-view">Review & Approve</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="10" class="no-data">No F-4 reimbursement applications pending final approval at this time.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>

    <div class="section-divider"></div>

    <!-- F-5 Conference Reimbursement Applications -->
    <h3>✈️ F-5 Conference/Workshop Reimbursement Applications - Final Approval</h3>
    <p style="color: #555; font-size: 14px; margin-top: -15px;">
        <em>These applications have been approved by HOD and are awaiting your final approval.</em>
    </p>

    <table>
        <thead>
            <tr>
                <th>Ref No.</th>
                <th>Faculty Name</th>
                <th>Employee Code</th>
                <th>Department</th>
                <th>Activity Type</th>
                <th>Activity Name</th>
                <th>Event Dates</th>
                <th>Location</th>
                <th>Attachments</th>
                <th>Total Amount (₹)</th>
                <th>HOD Status</th>
                <th>Submitted On</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result_f5->num_rows > 0): ?>
                <?php while ($row = $result_f5->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['ref_number']); ?></td>
                        <td><?= htmlspecialchars($row['faculty_name']); ?></td>
                        <td><?= htmlspecialchars($row['employee_code']); ?></td>
                        <td><?= htmlspecialchars($row['department']); ?></td>
                        <td>
                            <span class="badge"><?= htmlspecialchars($row['activity_nature']); ?></span>
                        </td>
                        <td><?= htmlspecialchars(substr($row['activity_name'], 0, 35)); ?>
                            <?= strlen($row['activity_name']) > 35 ? '...' : ''; ?>
                        </td>
                        <td style="white-space: nowrap; font-size: 12px;">
                            <?= date('d-M-y', strtotime($row['activity_start_date'])); ?> to<br>
                            <?= date('d-M-y', strtotime($row['activity_end_date'])); ?>
                        </td>
                        <td>
                            <span class="badge-location badge-<?= strtolower($row['location_type']); ?>">
                                <?= htmlspecialchars($row['location_type']); ?>
                            </span>
                        </td>
                        <td style="text-align: center;">
                            <?php if ($row['attachment_count'] > 0): ?>
                                <span class="badge" style="background: #6c757d;">📎 <?= $row['attachment_count']; ?></span>
                            <?php else: ?>
                                <span style="color: #999;">-</span>
                            <?php endif; ?>
                        </td>
                        <td style="text-align: right;">₹<?= number_format($row['total_amount'], 2); ?></td>
                        <td class="status-approved">
                            ✓ <?= htmlspecialchars($row['hod_status']); ?>
                        </td>
                        <td><?= date('d-M-Y', strtotime($row['created_at'])); ?></td>
                        <td>
                            <a href="ar_view_application.php?application_id=<?= $row['application_id']; ?>&type=f5" class="btn-view">Review & Approve</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="13" class="no-data">No F-5 conference reimbursement applications pending final approval at this time.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>

    <div class="section-divider"></div>

    <!-- Recent Activity -->
    <h3>📊 Recent Activity</h3>
    <table>
        <thead>
            <tr>
                <th>Form Type</th>
                <th>Ref Number</th>
                <th>Faculty Name</th>
                <th>Amount</th>
                <th>Final Status</th>
                <th>Last Updated</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result_recent->num_rows > 0): ?>
                <?php while ($row = $result_recent->fetch_assoc()): ?>
                    <tr>
                        <td><span class="badge-form"><?= htmlspecialchars($row['form_type']); ?></span></td>
                        <td><?= htmlspecialchars($row['ref_number']); ?></td>
                        <td><?= htmlspecialchars($row['faculty_name']); ?></td>
                        <td>₹<?= number_format($row['total_amount'], 2); ?></td>
                        <td>
                            <?php if (strpos($row['status'], 'APPROVED') !== false): ?>
                                <span class="status-approved"><?= htmlspecialchars($row['status']); ?></span>
                            <?php else: ?>
                                <span style="color: #dc3545; font-weight: bold;"><?= htmlspecialchars($row['status']); ?></span>
                            <?php endif; ?>
                        </td>
                        <td><?= date('d-M-Y H:i', strtotime($row['last_updated'])); ?></td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="6" class="no-data">No recent activity</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>
</div>

</body>
</html>

<?php
session_start();
include_once '../config/db.php';

// Redirect if not HOD
if ($_SESSION['role'] !== 'hod') {
    header("Location: login.php");
    exit();
}

$department = $_SESSION['department'];

// Query 1: Old CPDA Applications (Form 1 - Purchase/Membership)
$sql1 = "SELECT * FROM cpda_applications 
        WHERE department = ? 
          AND current_stage = 'HOD_REVIEW'
        ORDER BY created_at DESC";

$stmt1 = $conn->prepare($sql1);
$stmt1->bind_param("s", $department);
$stmt1->execute();
$result1 = $stmt1->get_result();

// Query 2: CPDA Event Applications (Event Participation Form)
$sql2 = "SELECT 
            a.application_id,
            a.ref_number,
            a.employee_code,
            a.faculty_name,
            a.title_of_event,
            a.venue_of_event,
            a.period_of_event,
            a.expense_total,
            a.submission_date,
            a.application_status,
            a.current_stage
        FROM cpda_event_applications a
        WHERE a.department = ? 
          AND a.current_stage = 'HOD_REVIEW'
        ORDER BY a.submission_date DESC"; 

$stmt2 = $conn->prepare($sql2);
$stmt2->bind_param("s", $department);
$stmt2->execute();
$result2 = $stmt2->get_result();

// Query 3: F-4 Reimbursement Applications
$sql3 = "SELECT 
            a.application_id,
            a.ref_number,
            a.employee_code,
            a.faculty_name,
            a.total_amount,
            a.submission_date,
            a.application_status,
            a.hod_approval_status,
            (SELECT COUNT(*) FROM f4_professional_memberships WHERE application_id = a.application_id) as membership_count
        FROM f4_reimbursement_applications a
        WHERE a.department = ? 
          AND a.application_status IN ('SUBMITTED', 'UNDER_REVIEW')
          AND a.hod_approval_status = 'PENDING'
        ORDER BY a.submission_date DESC";

$stmt3 = $conn->prepare($sql3);
$stmt3->bind_param("s", $department);
$stmt3->execute();
$result3 = $stmt3->get_result();

// Query 4: F-5 Conference Reimbursement Applications
$sql4 = "SELECT 
            f.application_id,
            f.ref_number,
            f.employee_code,
            f.faculty_name,
            f.activity_nature,
            f.activity_name,
            f.activity_start_date,
            f.activity_end_date,
            f.location_type,
            f.total_amount,
            f.created_at,
            f.hod_status,
            (SELECT COUNT(*) FROM f5_attachments WHERE reimbursement_id = f.application_id) as attachment_count
        FROM f5_conference_reimbursements f
        WHERE f.department = ? 
          AND f.hod_status = 'PENDING'
        ORDER BY f.created_at DESC";

$stmt4 = $conn->prepare($sql4);
$stmt4->bind_param("s", $department);
$stmt4->execute();
$result4 = $stmt4->get_result();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOD Dashboard</title>
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
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
        }
        h3 {
            color: #555;
            margin-top: 30px;
            background: #e3f2fd;
            padding: 12px;
            border-left: 4px solid #007bff;
        }
        .header-info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
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
            background-color: #007bff;
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
        .section-divider {
            margin: 40px 0;
            border-top: 2px solid #ddd;
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
        .summary-stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-card.green {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }
        .stat-card.orange {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        .stat-card.purple {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        .stat-number {
            font-size: 36px;
            font-weight: bold;
        }
        .stat-label {
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <a href="../controllers/logout.php" class="logout-btn">Logout</a>
    <h2>HOD Dashboard</h2>
    
    <div class="header-info">
        <strong>Welcome, <?= htmlspecialchars($_SESSION['name']); ?></strong><br>
        <strong>Department:</strong> <?= htmlspecialchars($department); ?><br>
        <strong>Role:</strong> Head of Department (HOD)
    </div>

    <!-- Summary Statistics -->
    <div class="summary-stats">
        <div class="stat-card">
            <div class="stat-number"><?= $result1->num_rows; ?></div>
            <div class="stat-label">Purchase Applications</div>
        </div>
        <div class="stat-card green">
            <div class="stat-number"><?= $result2->num_rows; ?></div>
            <div class="stat-label">Event Applications</div>
        </div>
        <div class="stat-card orange">
            <div class="stat-number"><?= $result3->num_rows; ?></div>
            <div class="stat-label">F-4 Reimbursements</div>
        </div>
        <div class="stat-card purple">
            <div class="stat-number"><?= $result4->num_rows; ?></div>
            <div class="stat-label">F-5 Conference</div>
        </div>
    </div>

    <!-- Section 1: CPDA Form 1 Applications (Purchase/Membership) -->
    <h3>📋 CPDA Purchase & Membership Applications</h3>

    <table>
        <thead>
            <tr>
                <th>Ref No</th>
                <th>Faculty Name</th>
                <th>Purpose</th>
                <th>Date Submitted</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result1->num_rows > 0): ?>
                <?php while ($row = $result1->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['ref_number']); ?></td>
                        <td><?= htmlspecialchars($row['faculty_name']); ?></td>
                        <td><?= htmlspecialchars(substr($row['purpose_of_purchase'], 0, 50)); ?>...</td>
                        <td><?= htmlspecialchars($row['created_at']); ?></td>
                        <td>
                            <a href="hod_view_application.php?application_id=<?= $row['application_id']; ?>&type=form1" class="btn-view">View</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="5" class="no-data">No pending Form 1 applications for review at this time.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>

    <div class="section-divider"></div>

    <!-- Section 2: CPDA Event Applications -->
    <h3>🎓 CPDA Event Participation Applications</h3>

    <table>
        <thead>
            <tr>
                <th>Ref No.</th>
                <th>Faculty Name</th>
                <th>Employee Code</th>
                <th>Event Title</th>
                <th>Venue</th>
                <th>Period</th>
                <th>Total Amount (₹)</th>
                <th>Submitted On</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result2->num_rows > 0): ?>
                <?php while ($row = $result2->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['ref_number']); ?></td>
                        <td><?= htmlspecialchars($row['faculty_name']); ?></td>
                        <td><?= htmlspecialchars($row['employee_code']); ?></td>
                        <td><?= htmlspecialchars(substr($row['title_of_event'], 0, 50)); ?>
                            <?= strlen($row['title_of_event']) > 50 ? '...' : ''; ?>
                        </td>
                        <td><?= htmlspecialchars(substr($row['venue_of_event'], 0, 30)); ?>
                            <?= strlen($row['venue_of_event']) > 30 ? '...' : ''; ?>
                        </td>
                        <td><?= htmlspecialchars($row['period_of_event']); ?></td>
                        <td style="text-align: right;">₹<?= number_format($row['expense_total'], 2); ?></td>
                        <td><?= date('d-M-Y', strtotime($row['submission_date'])); ?></td>
                        <td>
                            <a href="hod_view_application.php?application_id=<?= $row['application_id']; ?>&type=event" class="btn-view">View & Review</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="10" class="no-data">No pending event applications for review at this time.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>

    <div class="section-divider"></div>

    <!-- Section 3: F-4 Reimbursement Applications -->
    <h3>💰 F-4 Reimbursement Purchase & Membership Applications</h3>

    <table>
        <thead>
            <tr>
                <th>Ref No.</th>
                <th>Faculty Name</th>
                <th>Employee Code</th>
                <th>Memberships</th>
                <th>Total Amount (₹)</th>
                <th>Submitted On</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result3->num_rows > 0): ?>
                <?php while ($row = $result3->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['ref_number']); ?></td>
                        <td><?= htmlspecialchars($row['faculty_name']); ?></td>
                        <td><?= htmlspecialchars($row['employee_code']); ?></td>
                        <td>
                            <?php if ($row['membership_count'] > 0): ?>
                                <span class="badge"><?= $row['membership_count']; ?> Membership(s)</span>
                            <?php else: ?>
                                <span style="color: #999;">No memberships</span>
                            <?php endif; ?>
                        </td>
                        <td style="text-align: right;">₹<?= number_format($row['total_amount'], 2); ?></td>
                        <td><?= date('d-M-Y', strtotime($row['submission_date'])); ?></td>
                        <td class="status-pending"><?= htmlspecialchars($row['hod_approval_status']); ?></td>
                        <td>
                            <a href="hod_view_application.php?application_id=<?= $row['application_id']; ?>&type=f4" class="btn-view">View & Review</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="8" class="no-data">No pending F-4 reimbursement applications for review at this time.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>

    <div class="section-divider"></div>

    <!-- Section 4: F-5 Conference Reimbursement Applications -->
    <h3>✈️ F-5 Conference/Workshop Reimbursement Applications</h3>

    <table>
        <thead>
            <tr>
                <th>Ref No.</th>
                <th>Faculty Name</th>
                <th>Employee Code</th>
                <th>Activity Type</th>
                <th>Activity Name</th>
                <th>Event Dates</th>
                <th>Location</th>
                <th>Attachments</th>
                <th>Total Amount (₹)</th>
                <th>Submitted On</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result4->num_rows > 0): ?>
                <?php while ($row = $result4->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['ref_number']); ?></td>
                        <td><?= htmlspecialchars($row['faculty_name']); ?></td>
                        <td><?= htmlspecialchars($row['employee_code']); ?></td>
                        <td>
                            <span class="badge"><?= htmlspecialchars($row['activity_nature']); ?></span>
                        </td>
                        <td><?= htmlspecialchars(substr($row['activity_name'], 0, 40)); ?>
                            <?= strlen($row['activity_name']) > 40 ? '...' : ''; ?>
                        </td>
                        <td style="white-space: nowrap;">
                            <?= date('d-M-Y', strtotime($row['activity_start_date'])); ?> to<br>
                            <?= date('d-M-Y', strtotime($row['activity_end_date'])); ?>
                        </td>
                        <td>
                            <span class="badge-location badge-<?= strtolower($row['location_type']); ?>">
                                <?= htmlspecialchars($row['location_type']); ?>
                            </span>
                        </td>
                        <td style="text-align: center;">
                            <?php if ($row['attachment_count'] > 0): ?>
                                📎 <?= $row['attachment_count']; ?> file(s)
                            <?php else: ?>
                                <span style="color: #999;">-</span>
                            <?php endif; ?>
                        </td>
                        <td style="text-align: right;">₹<?= number_format($row['total_amount'], 2); ?></td>
                        <td><?= date('d-M-Y', strtotime($row['created_at'])); ?></td>
                        <td class="status-pending"><?= htmlspecialchars($row['hod_status']); ?></td>
                        <td>
                            <a href="hod_view_application.php?application_id=<?= $row['application_id']; ?>&type=f5" class="btn-view">View & Review</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="12" class="no-data">No pending F-5 conference reimbursement applications for review at this time.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>
</div>

</body>
</html>

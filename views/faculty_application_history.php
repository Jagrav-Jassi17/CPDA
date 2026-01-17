<?php
session_start();
include_once '../config/db.php';

// Ensure user is logged in as faculty
if (!isset($_SESSION['employee_code'])) {
    header("Location: ../views/login.php");
    exit();
}

$employee_code = $_SESSION['employee_code'];

/* ==========================================================
   FETCH FORM-1 (CPDA Permission – Purchase & Membership)
   ========================================================== */
$stmt = $conn->prepare("
    SELECT ref_number, application_id, status, current_stage, created_at
    FROM cpda_applications
    WHERE employee_code = ?
    ORDER BY created_at DESC
");
$stmt->bind_param("s", $employee_code);
$stmt->execute();
$applications = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();

/* ==========================================================
   FETCH FORM-2 (CPDA Permission – Events)
   ========================================================== */
$stmt2 = $conn->prepare("
    SELECT ref_number, application_id, application_status, created_at
    FROM cpda_event_applications
    WHERE employee_code = ?
    ORDER BY created_at DESC
");
$stmt2->bind_param("s", $employee_code);
$stmt2->execute();
$applications2 = $stmt2->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt2->close();

/* ==========================================================
   FETCH FORM-4 (Reimbursement – Purchase & Membership)
   ========================================================== */
$stmt3 = $conn->prepare("
    SELECT ref_number, application_id, application_status, created_at
    FROM f4_reimbursement_applications
    WHERE employee_code = ?
    ORDER BY created_at DESC
");
$stmt3->bind_param("s", $employee_code);
$stmt3->execute();
$applications3 = $stmt3->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt3->close();

/* ==========================================================
   FETCH FORM-5 (Reimbursement – Events)
   ========================================================== */
$stmt4 = $conn->prepare("
    SELECT ref_number, application_id, status, created_at
    FROM f5_conference_reimbursements
    WHERE employee_code = ?
    ORDER BY created_at DESC
");
$stmt4->bind_param("s", $employee_code);
$stmt4->execute();
$applications4 = $stmt4->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt4->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>My CPDA Applications</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin-bottom: 30px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        a.btn {
            padding: 6px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 13px;
            margin: 2px;
            display: inline-block;
        }
        .btn-view { background: #e3f2fd; color: #000; }
        .btn-balance { background: #e8f5e9; color: #000; }
        .btn-edit { background: #ffeb3b; color: #000; }
        .reverted { color: #d32f2f; font-weight: bold; }
    </style>
</head>
<body>

<p><a href="faculty_dashboard.php">⬅ Back to Dashboard</a></p>

<!-- ===================================================== -->
<h2>Form 1 – CPDA Permission (Purchase & Membership)</h2>
<table>
    <thead>
        <tr>
            <th>Reference No</th>
            <th>Status</th>
            <!-- <th>Accounts Status</th> -->
            <th>Submitted</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php if (empty($applications)): ?>
            <tr><td colspan="5">No applications found.</td></tr>
        <?php else: foreach ($applications as $app): ?>
            <tr>
                <td><?= htmlspecialchars($app['ref_number']) ?></td>
                <td><?= htmlspecialchars($app['status']) ?></td>
                <!-- <td class="<?= $app['accounts_status'] === 'REVERTED' ? 'reverted' : '' ?>">
                    <?= htmlspecialchars($app['accounts_status']) ?>
                </td> -->
                <td><?= htmlspecialchars($app['created_at']) ?></td>
                <td>
                    <a class="btn btn-view"
                       href="faculty_view_application_flow.php?ref_number=<?= urlencode($app['ref_number']) ?>">
                       View
                    </a>

                    <a class="btn btn-balance"
                       href="balance_view.php?form_type=F1&form_id=<?= (int)$app['application_id'] ?>">
                       Balance
                    </a>

                    <!-- <?php if ($app['accounts_status'] === 'REVERTED' &&
                              $app['current_stage'] === 'FACULTY_EDIT'): ?>
                        <a class="btn btn-edit"
                           href="form1_edit.php?application_id=<?= (int)$app['application_id'] ?>">
                           Edit & Resubmit
                        </a>
                    <?php endif; ?> -->
                </td>
            </tr>
        <?php endforeach; endif; ?>
    </tbody>
</table>

<!-- ===================================================== -->
<h2>Form 2 – CPDA Permission (Events)</h2>
<table>
    <thead>
        <tr>
            <th>Reference No</th>
            <th>Status</th>
            <th>Submitted</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <?php if (empty($applications2)): ?>
            <tr><td colspan="4">No applications found.</td></tr>
        <?php else: foreach ($applications2 as $app): ?>
            <tr>
                <td><?= htmlspecialchars($app['ref_number']) ?></td>
                <td><?= htmlspecialchars($app['application_status']) ?></td>
                <td><?= htmlspecialchars($app['created_at']) ?></td>
                <td>
                    <a class="btn btn-view"
                       href="faculty_view_application_flow.php?ref_number=<?= urlencode($app['ref_number']) ?>">
                       View
                    </a>
                </td>
            </tr>
        <?php endforeach; endif; ?>
    </tbody>
</table>

<!-- ===================================================== -->
<h2>Form 4 – Reimbursement (Purchase & Membership)</h2>
<table>
    <thead>
        <tr>
            <th>Reference No</th>
            <th>Status</th>
            <th>Submitted</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <?php if (empty($applications3)): ?>
            <tr><td colspan="4">No applications found.</td></tr>
        <?php else: foreach ($applications3 as $app): ?>
            <tr>
                <td><?= htmlspecialchars($app['ref_number']) ?></td>
                <td><?= htmlspecialchars($app['application_status']) ?></td>
                <td><?= htmlspecialchars($app['created_at']) ?></td>
                <td>
                    <a class="btn btn-view"
                       href="faculty_view_application_flow.php?ref_number=<?= urlencode($app['ref_number']) ?>">
                       View
                    </a>
                </td>
            </tr>
        <?php endforeach; endif; ?>
    </tbody>
</table>

<!-- ===================================================== -->
<h2>Form 5 – Reimbursement (Events)</h2>
<table>
    <thead>
        <tr>
            <th>Reference No</th>
            <th>Status</th>
            <th>Submitted</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <?php if (empty($applications4)): ?>
            <tr><td colspan="4">No applications found.</td></tr>
        <?php else: foreach ($applications4 as $app): ?>
            <tr>
                <td><?= htmlspecialchars($app['ref_number']) ?></td>
                <td><?= htmlspecialchars($app['status']) ?></td>
                <td><?= htmlspecialchars($app['created_at']) ?></td>
                <td>
                    <a class="btn btn-view"
                       href="faculty_view_application_flow.php?ref_number=<?= urlencode($app['ref_number']) ?>">
                       View
                    </a>
                </td>
            </tr>
        <?php endforeach; endif; ?>
    </tbody>
</table>

</body>
</html>

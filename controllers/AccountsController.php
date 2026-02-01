<?php
require_once __DIR__ . '/../config/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $applicationId = intval($_POST['Application_ID']);
    $type = $_POST['type'] ?? 'cpda'; // cpda | reimbursement

    $conn->begin_transaction();

    try {

        /* =====================================================
           CASE 1: CPDA APPLICATION (FORM 1 / 2)  ✅ EXISTING LOGIC
        ===================================================== */
        if ($type === 'cpda') {

            $amountSpent     = floatval($_POST['Conf_Amt_Spent']);
            $numEvents       = $_POST['Conf_Num_Events'] ?? null;
            $amountCommitted = floatval($_POST['Conf_Amt_Committed'] ?? 0);

            // 1. Save expenditure
            $stmt = $conn->prepare("
                INSERT INTO cpda_expenditure
                (application_id, num_events, amount_spent, amount_committed)
                VALUES (?, ?, ?, ?)
            ");
            $stmt->bind_param("iidd", $applicationId, $numEvents, $amountSpent, $amountCommitted);
            $stmt->execute();
            $stmt->close();

            // 2. Get faculty
            $stmt = $conn->prepare("
                SELECT employee_code
                FROM cpda_applications
                WHERE id = ? AND status = 'HOD_APPROVED'
            ");
            $stmt->bind_param("i", $applicationId);
            $stmt->execute();
            $res = $stmt->get_result();

            if ($res->num_rows === 0) {
                throw new Exception("Invalid CPDA application");
            }

            $facultyId = $res->fetch_assoc()['employee_code'];
            $stmt->close();

            // 3. Get blocked amount
            $stmt = $conn->prepare("
                SELECT block_id, amount
                FROM cpda_balance_blocked
                WHERE application_id = ? AND status = 'BLOCKED'
            ");
            $stmt->bind_param("i", $applicationId);
            $stmt->execute();
            $block = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            if (!$block) {
                throw new Exception("No blocked amount found");
            }

            if ($amountSpent > $block['amount']) {
                throw new Exception("Spent exceeds blocked amount");
            }

            // 4. Ensure master balance
            $stmt = $conn->prepare("
                INSERT INTO cpda_balance_master (faculty_id)
                VALUES (?)
                ON DUPLICATE KEY UPDATE faculty_id = faculty_id
            ");
            $stmt->bind_param("s", $facultyId);
            $stmt->execute();
            $stmt->close();

            // 5. Update ACTUAL balance
            $stmt = $conn->prepare("
                UPDATE cpda_balance_master
                SET utilized_amount = utilized_amount + ?
                WHERE faculty_id = ?
            ");
            $stmt->bind_param("ds", $amountSpent, $facultyId);
            $stmt->execute();
            $stmt->close();

            // 6. Consume blocked
            $stmt = $conn->prepare("
                UPDATE cpda_balance_blocked
                SET status = 'CONSUMED'
                WHERE block_id = ?
            ");
            $stmt->bind_param("i", $block['block_id']);
            $stmt->execute();
            $stmt->close();

            // 7. Finalize application
            $stmt = $conn->prepare("
                UPDATE cpda_applications
                SET accounts_status = 'APPROVED',
                    current_stage = 'COMPLETED',
                    updated_at = NOW()
                WHERE id = ?
            ");
            $stmt->bind_param("i", $applicationId);
            $stmt->execute();
            $stmt->close();
        }

        /* =====================================================
           CASE 2: REIMBURSEMENT (FORM 3 / 4) ✅ NEW LOGIC
        ===================================================== */
        if ($type === 'reimbursement') {

            // 1. Fetch reimbursement
            $stmt = $conn->prepare("
                SELECT employee_code, total_amount, balance_applied
                FROM f4_reimbursement_applications
                WHERE id = ? AND application_status = 'AR_APPROVED'
                FOR UPDATE
            ");
            $stmt->bind_param("i", $applicationId);
            $stmt->execute();
            $res = $stmt->get_result();

            if ($res->num_rows === 0) {
                throw new Exception("Invalid reimbursement");
            }

            $row = $res->fetch_assoc();
            if ($row['balance_applied'] == 1) {
                throw new Exception("Balance already applied");
            }

            $facultyId = $row['employee_code'];
            $amount = floatval($row['total_amount']);
            $stmt->close();

            // 2. Ensure master balance
            $stmt = $conn->prepare("
                INSERT INTO cpda_balance_master (faculty_id)
                VALUES (?)
                ON DUPLICATE KEY UPDATE faculty_id = faculty_id
            ");
            $stmt->bind_param("s", $facultyId);
            $stmt->execute();
            $stmt->close();

            // 3. Update ACTUAL CPDA balance
            $stmt = $conn->prepare("
                UPDATE cpda_balance_master
                SET utilized_amount = utilized_amount + ?
                WHERE faculty_id = ?
            ");
            $stmt->bind_param("ds", $amount, $facultyId);
            $stmt->execute();
            $stmt->close();

            // 4. Lock reimbursement
            $stmt = $conn->prepare("
                UPDATE f4_reimbursement_applications
                SET balance_applied = 1
                WHERE id = ?
            ");
            $stmt->bind_param("i", $applicationId);
            $stmt->execute();
            $stmt->close();
        }

        $conn->commit();
        header("Location: ../views/accounts_success.php");
        exit();

    } catch (Exception $e) {
        $conn->rollback();
        echo "Accounts approval failed: " . $e->getMessage();
    }
}

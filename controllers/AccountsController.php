<?php
require_once __DIR__ . '/../config/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $applicationId   = intval($_POST['Application_ID']);
    $amountSpent     = floatval($_POST['Conf_Amt_Spent']);
    $numEvents       = $_POST['Conf_Num_Events'] ?? null;
    $amountCommitted = floatval($_POST['Conf_Amt_Committed'] ?? 0);

    $conn->begin_transaction();

    try {

        /* =====================================================
           1. Save expenditure details (FACTUAL DATA ONLY)
        ===================================================== */
        $stmt = $conn->prepare("
            INSERT INTO cpda_expenditure
            (application_id, num_events, amount_spent, amount_committed)
            VALUES (?, ?, ?, ?)
        ");
        $stmt->bind_param(
            "iidd",
            $applicationId,
            $numEvents,
            $amountSpent,
            $amountCommitted
        );

        if (!$stmt->execute()) {
            throw new Exception("Failed to save expenditure details");
        }
        $stmt->close();

        /* =====================================================
           2. Fetch faculty + blocked amount
        ===================================================== */
        $stmt = $conn->prepare("
            SELECT employee_code
            FROM cpda_applications
            WHERE id = ?
              AND status = 'HOD_APPROVED'
        ");
        $stmt->bind_param("i", $applicationId);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows === 0) {
            throw new Exception("Invalid or unapproved application");
        }

        $row = $res->fetch_assoc();
        $facultyId = $row['employee_code'];
        $stmt->close();

        /* =====================================================
           3. Get BLOCKED amount (must exist)
        ===================================================== */
        $stmt = $conn->prepare("
            SELECT block_id, amount
            FROM cpda_balance_blocked
            WHERE application_id = ?
              AND status = 'BLOCKED'
        ");
        $stmt->bind_param("i", $applicationId);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows === 0) {
            throw new Exception("No blocked amount found for this application");
        }

        $block = $res->fetch_assoc();
        $blockId       = $block['block_id'];
        $blockedAmount = floatval($block['amount']);
        $stmt->close();

        /* =====================================================
           4. Ensure master balance row exists
        ===================================================== */
        $stmt = $conn->prepare("
            INSERT INTO cpda_balance_master (faculty_id)
            VALUES (?)
            ON DUPLICATE KEY UPDATE faculty_id = faculty_id
        ");
        $stmt->bind_param("s", $facultyId);

        if (!$stmt->execute()) {
            throw new Exception("Failed to ensure balance master row");
        }
        $stmt->close();

        /* =====================================================
           5. FINAL BALANCE UPDATE (REAL MONEY MOVEMENT)
        ===================================================== */
        if ($amountSpent > $blockedAmount) {
            throw new Exception("Spent amount exceeds blocked amount");
        }

        $stmt = $conn->prepare("
            UPDATE cpda_balance_master
            SET utilized_amount = utilized_amount + ?
            WHERE faculty_id = ?
        ");
        $stmt->bind_param("ds", $amountSpent, $facultyId);

        if (!$stmt->execute()) {
            throw new Exception("Failed to update master balance");
        }
        $stmt->close();

        /* =====================================================
           6. Mark blocked amount as CONSUMED
        ===================================================== */
        $stmt = $conn->prepare("
            UPDATE cpda_balance_blocked
            SET status = 'CONSUMED'
            WHERE block_id = ?
        ");
        $stmt->bind_param("i", $blockId);

        if (!$stmt->execute()) {
            throw new Exception("Failed to consume blocked amount");
        }
        $stmt->close();

        /* =====================================================
           7. Mark application as ACCOUNTS APPROVED
        ===================================================== */
        $stmt = $conn->prepare("
            UPDATE cpda_applications
            SET accounts_status = 'APPROVED',
                current_stage = 'COMPLETED',
                updated_at = NOW()
            WHERE id = ?
        ");
        $stmt->bind_param("i", $applicationId);

        if (!$stmt->execute()) {
            throw new Exception("Failed to finalize application");
        }
        $stmt->close();

        /* =====================================================
           8. COMMIT EVERYTHING
        ===================================================== */
        $conn->commit();

        header("Location: ../views/accounts_success.php");
        exit();

    } catch (Exception $e) {

        $conn->rollback();
        echo "Accounts approval failed: " . $e->getMessage();
    }
}

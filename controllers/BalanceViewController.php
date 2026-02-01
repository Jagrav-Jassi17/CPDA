<?php
require_once __DIR__ . '/../config/db.php';

class BalanceViewController
{
    private $conn;
    private $TOTAL_CPDA = 300000;

    public function __construct()
    {
        global $conn;
        $this->conn = $conn;
    }

    /* =====================================================
       BALANCE FOR A SINGLE APPLICATION
       ===================================================== */
    public function getBalanceByForm(string $formType, int $formId): array
    {
        // Faculty-specific approved balance
        $facultyId = $_SESSION['employee_code'];
        $approvedBalance = $this->getCurrentApprovedBalance($facultyId);

        $amount = $this->getApplicationAmount($formType, $formId);

        return [
            'form_type'         => $formType,
            'form_id'           => $formId,
            'approved_balance'  => $approvedBalance,
            'temporary_balance' => $approvedBalance - $amount,
            'status'            => 'TEMP'
        ];
    }

    /* =====================================================
       APPLICATION AMOUNT
       ===================================================== */
    private function getApplicationAmount(string $formType, int $formId): float
    {
        // F1 – CPDA Purchase & Membership
        if ($formType === 'F1') {
            $stmt = $this->conn->prepare("
                SELECT 
                    IFNULL((SELECT SUM(amount) FROM professional_memberships WHERE application_id = ?),0) +
                    IFNULL((SELECT SUM(amount) FROM consumable_items WHERE application_id = ?),0) AS total
            ");
            $stmt->bind_param("ii", $formId, $formId);
            $stmt->execute();
            return (float)$stmt->get_result()->fetch_assoc()['total'];
        }

        // F4 – Reimbursement (Purchase & Membership)
        if ($formType === 'F4') {
            $stmt = $this->conn->prepare("
                SELECT IFNULL(total_amount,0) AS total
                FROM f4_reimbursement_applications
                WHERE application_id = ?
            ");
            $stmt->bind_param("i", $formId);
            $stmt->execute();
            return (float)$stmt->get_result()->fetch_assoc()['total'];
        }

        // F5 – Conference Reimbursement
        if ($formType === 'F5') {
            $stmt = $this->conn->prepare("
                SELECT IFNULL(total_amount,0) AS total
                FROM f5_conference_reimbursements
                WHERE application_id = ?
            ");
            $stmt->bind_param("i", $formId);
            $stmt->execute();
            return (float)$stmt->get_result()->fetch_assoc()['total'];
        }

        return 0.0;
    }

    public function getApplicationAmountPublic(string $formType, int $formId): float
    {
        return $this->getApplicationAmount($formType, $formId);
    }

    /* =====================================================
       APPROVED CPDA BALANCE (SOURCE OF TRUTH)
       ===================================================== */
    public function getCurrentApprovedBalance(string $facultyId): float
    {
        $stmt = $this->conn->prepare("
            SELECT total_allocated - utilized_amount AS approved_balance
            FROM cpda_balance_master
            WHERE faculty_id = ?
        ");
        $stmt->bind_param("s", $facultyId);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res && $res->num_rows > 0) {
            return (float)$res->fetch_assoc()['approved_balance'];
        }

        // Default CPDA if no record exists
        return $this->TOTAL_CPDA;
    }

    /* =====================================================
       SNAPSHOT (OPTIONAL – FOR AUDIT / HISTORY)
       ===================================================== */
    public function approveBalanceForApplication(
        string $formType,
        int $formId,
        float $approvedBalance,
        string $approvedBy
    ): bool {
        if (!in_array($formType, ['F4','F5'])) {
            return false;
        }

        $stmt = $this->conn->prepare("
            INSERT INTO cpda_balance_snapshot
            (form_type, form_id, approved_balance, temporary_balance, status, approved_by, approved_at)
            VALUES (?, ?, ?, ?, 'APPROVED', ?, NOW())
        ");

        $stmt->bind_param(
            "sidss",
            $formType,
            $formId,
            $approvedBalance,
            $approvedBalance,
            $approvedBy
        );

        return $stmt->execute();
    }

    /* =====================================================
       ACCOUNTS DECISION (LEGACY – SAFE)
       ===================================================== */
    public function updateAccountsDecision(
        int $formId,
        string $decision,
        ?string $remarks,
        bool $revertToFaculty = false
    ): bool {
        $stmt = $this->conn->prepare("
            UPDATE cpda_applications
            SET accounts_status = ?,
                accounts_remarks = ?,
                accounts_action_at = NOW()
            WHERE application_id = ?
        ");
        $stmt->bind_param("ssi", $decision, $remarks, $formId);
        $ok = $stmt->execute();

        if ($ok && $revertToFaculty) {
            $stmt2 = $this->conn->prepare("
                UPDATE cpda_applications
                SET current_stage = 'FACULTY_EDIT'
                WHERE application_id = ?
            ");
            $stmt2->bind_param("i", $formId);
            $stmt2->execute();
        }

        return $ok;
    }
}

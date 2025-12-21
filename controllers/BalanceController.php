<?php
require_once __DIR__ . '/../config/db.php';

class BalanceController
{
    private $conn;

    public function __construct()
    {
        global $conn;
        $this->conn = $conn;
    }

    // Real available balance (changes only after final reimbursement)
    public function getAvailableBalance($facultyId)
    {
        $stmt = $this->conn->prepare("
            SELECT 
                total_allocated - utilized_amount AS available_balance
            FROM cpda_balance_master
            WHERE faculty_id = ?
        ");
        $stmt->bind_param("s", $facultyId);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($row = $res->fetch_assoc()) {
            return (float)$row['available_balance'];
        }

        // Default CPDA block if no record exists
        return 300000;
    }

    // Total amount currently blocked by F1 + F2
    public function getBlockedAmount($facultyId)
    {
        $stmt = $this->conn->prepare("
            SELECT COALESCE(SUM(amount), 0) AS blocked_amount
            FROM cpda_balance_blocked
            WHERE faculty_id = ?
              AND status = 'BLOCKED'
        ");
        $stmt->bind_param("s", $facultyId);
        $stmt->execute();
        $res = $stmt->get_result();

        $row = $res->fetch_assoc();
        return (float)$row['blocked_amount'];
    }

    // Amount faculty can still plan for new F1/F2
    public function getUsableBalance($facultyId)
    {
        $available = $this->getAvailableBalance($facultyId);
        $blocked   = $this->getBlockedAmount($facultyId);

        return max(0, $available - $blocked);
    }
}

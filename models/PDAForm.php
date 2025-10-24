<?php
class PDAForm {
    private $conn;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function createForm($data) {
        $sql = "INSERT INTO cpda_pda_form 
                (user_id, block_year_from, block_year_to, purpose, tech_spec, remarks, total_requested) 
                VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param(
            "iissssd",
            $data['user_id'],
            $data['block_year_from'],
            $data['block_year_to'],
            $data['purpose'],
            $data['tech_spec'],
            $data['remarks'],
            $data['total_requested']
        );
        return $stmt->execute();
    }

    public function getFormsByUser($userId) {
        $sql = "SELECT * FROM cpda_pda_form WHERE user_id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        return $stmt->get_result();
    }
}
?>

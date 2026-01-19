<?php
session_start();
include_once '../config/db.php';

if ($_SESSION['role'] !== 'accounts_ar') {
    http_response_code(403);
    exit("Unauthorized");
}

$data = json_decode(file_get_contents("php://input"), true);

$allowed = [
    'fdx_expenditure_main' => [
        'P1_Conferences_Y1_Num_Events',
        'P1_Conferences_Y2_Num_Events',
        'P1_Conferences_Y3_Num_Events',
        'P1_Conferences_Y1_Amt_Spent',
        'P1_Conferences_Y2_Amt_Spent',
        'P1_Conferences_Y3_Amt_Spent',
        'P1_Conferences_Y1_Amt_Committed',
        'P1_Conferences_Y2_Amt_Committed',
        'P1_Conferences_Y3_Amt_Committed',
        'P1_Conferences_Y1_Balance',
        'P1_Conferences_Y2_Balance',
        'P1_Conferences_Y3_Balance',
        'P1_Conferences_Total_Spent',
        'P1_Conferences_Total_Committed',
        'P1_Conferences_Final_Balance',
        'P2_Membership_Y1_Num_Availed',
        'P2_Membership_Y2_Num_Availed',
        'P2_Membership_Y3_Num_Availed',
        'P2_Membership_Y1_Amt_Spent',
        'P2_Membership_Y2_Amt_Spent',
        'P2_Membership_Y3_Amt_Spent',
        'P2_Membership_Y1_Amt_Committed',
        'P2_Membership_Y2_Amt_Committed',
        'P2_Membership_Y3_Amt_Committed',
        'P2_Membership_Y1_Balance',
        'P2_Membership_Y2_Balance',
        'P2_Membership_Y3_Balance',
        'P2_Membership_Total_Spent',
        'P2_Membership_Total_Committed',
        'P2_Membership_Final_Balance',
        'P3a_Consumables_Y1_Amt_Committed',
        'P3a_Consumables_Y2_Amt_Committed',
        'P3a_Consumables_Y3_Amt_Committed',
        'P3a_Consumables_Balance',
        'P3b_Synthesis_Testing_Y1_Amt_Committed',
        'P3b_Synthesis_Testing_Y2_Amt_Committed',
        'P3b_Synthesis_Testing_Y3_Amt_Committed',
        'P3b_Synthesis_Testing_Balance',
        'P3c_i_Stationary_Y1_Amt_Committed',
        'P3c_i_Stationary_Y2_Amt_Committed',
        'P3c_i_Stationary_Y3_Amt_Committed',
        'P3c_i_Stationary_Balance',
        'P3c_ii_Books_Y1_Amt_Committed',
        'P3c_ii_Books_Y2_Amt_Committed',
        'P3c_ii_Books_Y3_Amt_Committed',
        'P3c_ii_Books_Balance',
        'P3d_Computer_Consumables_Y1_Amt_Committed',
        'P3d_Computer_Consumables_Y2_Amt_Committed',
        'P3d_Computer_Consumables_Y3_Amt_Committed',
        'P3d_Computer_Consumables_Balance'
    ],
    'fdx_electronic_devices' => [
        'Item_Description',
        'Cost_at_Time_of_Issue',
        'Date_of_Issue'
    ]
];

$conn->begin_transaction();

try {
    foreach ($data as $row) {

        if (
            !isset($allowed[$row['table']]) ||
            !in_array($row['column'], $allowed[$row['table']])
        ) {
            throw new Exception("Invalid column");
        }

        $stmt = $conn->prepare(
            "UPDATE {$row['table']} 
             SET {$row['column']} = ? 
             WHERE employee_code = ?"
        );

        $stmt->bind_param("ds", $row['value'], $row['emp']);
        $stmt->execute();
    }

    $conn->commit();
    echo "All changes saved successfully";
} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo "Failed to save changes";
}

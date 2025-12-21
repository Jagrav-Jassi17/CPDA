<?php
session_start();
include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $employee_code = $_POST['employee_code'];
    $faculty_name  = $_POST['faculty_name'];
    $email         = $_POST['email'];
    $mobile        = $_POST['mobile_number'];
    $designation   = $_POST['designation'];
    $department    = $_POST['department'];
    $pay_level     = $_POST['pay_level'];
    $date_of_join  = $_POST['date_of_joining'];
    $purpose       = $_POST['purpose_of_purchase'];
    $specs         = $_POST['technical_specification'];
    $remarks       = $_POST['remarks'];

    $conn->begin_transaction();

    try {
        $ref = 'CPDA-' . strtoupper(uniqid());

        $stmt = $conn->prepare("
            INSERT INTO cpda_applications
            (ref_number, dated, employee_code, faculty_name, email, mobile_number,
             designation, department, pay_level, date_of_joining,
             purpose_of_purchase, technical_specification, remarks,
             status, current_stage, accounts_status)
            VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'SUBMITTED', 'HOD_REVIEW', 'PENDING')
        ");

        $stmt->bind_param(
            "ssssssssssss",
            $ref, $employee_code, $faculty_name, $email, $mobile,
            $designation, $department, $pay_level, $date_of_join,
            $purpose, $specs, $remarks
        );
        $stmt->execute();
        $application_id = $conn->insert_id;

        if (!empty($_POST['membership_body_name'])) {
            $stmt2 = $conn->prepare("
                INSERT INTO professional_memberships
                (application_id, professional_body_name, amount, membership_type)
                VALUES (?, ?, ?, ?)
            ");
            foreach ($_POST['membership_body_name'] as $i => $body) {
                $amt  = (float)$_POST['membership_amount'][$i];
                $type = $_POST['membership_type'][$i];
                $stmt2->bind_param("isds", $application_id, $body, $amt, $type);
                $stmt2->execute();
            }
        }

        if (!empty($_POST['article_name'])) {
            $stmt3 = $conn->prepare("
                INSERT INTO consumable_items
                (application_id, serial_number, article_name, amount, item_category)
                VALUES (?, ?, ?, ?, ?)
            ");
            foreach ($_POST['article_name'] as $i => $article) {
                $stmt3->bind_param(
                    "iisds",
                    $application_id,
                    $i + 1,
                    $article,
                    (float)$_POST['article_amount'][$i],
                    $_POST['item_category'][$i]
                );
                $stmt3->execute();
            }
        }

        $conn->commit();
        header("Location: ../views/faculty_dashboard.php");
        exit;

    } catch (Exception $e) {
        $conn->rollback();
        echo "Error: " . $e->getMessage();
    }
}

<?php
session_start();
include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $employee_code = $_POST['employee_code'];
    $faculty_name = $_POST['faculty_name'];
    $email = $_POST['email'];
    $mobile = $_POST['mobile_number'];
    $designation = $_POST['designation'];
    $department = $_POST['department'];
    $pay_level = $_POST['pay_level'];
    $date_of_joining = $_POST['date_of_joining'];
    $purpose = $_POST['purpose_of_purchase'];
    $specs = $_POST['technical_specification'];
    $remarks = $_POST['remarks'];

    // main application insert
    $conn->begin_transaction();
    try {
        $ref = 'CPDA-' . strtoupper(uniqid());
        $stmt = $conn->prepare("INSERT INTO cpda_applications
            (ref_number, dated, employee_code, faculty_name, email, mobile_number,
             designation, department, pay_level, date_of_joining, purpose_of_purchase,
             technical_specification, remarks, status, current_stage)
            VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'SUBMITTED', 'HOD_REVIEW')");
        $stmt->bind_param("ssssssssssss",
            $ref, $employee_code, $faculty_name, $email, $mobile, $designation,
            $department, $pay_level, $date_of_joining, $purpose, $specs, $remarks
        );
        $stmt->execute();
        $application_id = $conn->insert_id;

        // professional memberships
        if (!empty($_POST['membership_body_name'])) {
            $stmt2 = $conn->prepare("INSERT INTO professional_memberships
                (application_id, professional_body_name, amount, membership_type)
                VALUES (?, ?, ?, ?)");
            foreach ($_POST['membership_body_name'] as $i => $body) {
                $amt = $_POST['membership_amount'][$i];
                $type = $_POST['membership_type'][$i];
                $stmt2->bind_param("isds", $application_id, $body, $amt, $type);
                $stmt2->execute();
            }
        }

        // consumable items
        if (!empty($_POST['article_name'])) {
            
            // FIX 1: Add the serial_number column to the SQL statement.
            // Assuming the column name in your table is 'serial_number' or similar (e.g., 'item_sno').
            $stmt3 = $conn->prepare("INSERT INTO consumable_items
                (application_id, serial_number, article_name, amount, item_category)
                VALUES (?, ?, ?, ?, ?)"); 

            // Loop through the submitted items
            foreach ($_POST['article_name'] as $i => $article) {
                
                // FIX 2: Calculate serial number directly inside the loop (starts at 1)
                $serial_number = $i + 1; 
                
                $amt = $_POST['article_amount'][$i];
                $cat = $_POST['item_category'][$i];

                // FIX 3: Correct the bind_param types to match the 5 variables:
                // (application_id (i), serial_number (i), article (s), amount (d), category (s))
                $stmt3->bind_param("iisds", $application_id, $serial_number, $article, $amt, $cat);
                $stmt3->execute();
                
                // No need to calculate serial_number again here.
            }
        }

        $conn->commit();
        echo "<script>alert('Form submitted successfully!'); window.location.href='../views/faculty_dashboard.php';</script>";
    } catch (Exception $e) {
        $conn->rollback();
        echo "Error saving application: " . $e->getMessage();
    }
}
?>

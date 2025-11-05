<?php
session_start();
if ($_SESSION['role'] !== 'faculty') {
    header("Location: ../login.php");
    exit();
}

include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // Start transaction
    $conn->begin_transaction();
    
    try {
        // Sanitize and validate input data
        $employee_code = $_SESSION['employee_code'];
        $faculty_name = $_SESSION['name'];
        $designation = $_SESSION['role'];
        $pay_level = $_SESSION['pay_level'];
        $department = $_SESSION['department'];
        
        // Activity Details
        $activity_nature = trim($_POST['activity_nature']);
        $activity_name = trim($_POST['activity_name']);
        $activity_start_date = $_POST['activity_start_date'];
        $activity_end_date = $_POST['activity_end_date'];
        $activity_venue = trim($_POST['activity_venue']);
        $location_type = $_POST['location_type'];
        
        // Expenditure Details
        $expense_registration = floatval($_POST['expense_registration'] ?? 0);
        $expense_visa = floatval($_POST['expense_visa'] ?? 0);
        $expense_insurance = floatval($_POST['expense_insurance'] ?? 0);
        $expense_air_fare = floatval($_POST['expense_air_fare'] ?? 0);
        $expense_local_travel = floatval($_POST['expense_local_travel'] ?? 0);
        $expense_da_per_diem = floatval($_POST['expense_da_per_diem'] ?? 0);
        $expense_boarding_lodging = floatval($_POST['expense_boarding_lodging'] ?? 0);
        $expense_other = floatval($_POST['expense_other'] ?? 0);
        $expense_other_description = trim($_POST['expense_other_description'] ?? '');
        
        $total_amount = floatval($_POST['total_amount']);
        $remarks = trim($_POST['remarks'] ?? '');
        
        // Generate unique reference number
        $year = date('Y');
        $ref_number = "CPDA/F5/" . $year . "/" . uniqid();
        
        // Validate dates
        if (strtotime($activity_end_date) < strtotime($activity_start_date)) {
            throw new Exception("End date cannot be before start date.");
        }
        
        // Validate total amount
        $calculated_total = $expense_registration + $expense_visa + $expense_insurance + 
                           $expense_air_fare + $expense_local_travel + $expense_da_per_diem + 
                           $expense_boarding_lodging + $expense_other;
        
        if (abs($calculated_total - $total_amount) > 0.01) {
            throw new Exception("Total amount mismatch. Please recalculate.");
        }
        
        // Insert main reimbursement record
        $stmt = $conn->prepare("
            INSERT INTO f5_conference_reimbursements (
                ref_number, employee_code, faculty_name, designation, pay_level, department,
                activity_nature, activity_name, activity_start_date, activity_end_date, 
                activity_venue, location_type,
                expense_registration, expense_visa, expense_insurance, expense_air_fare,
                expense_local_travel, expense_da_per_diem, expense_boarding_lodging,
                expense_other, expense_other_description,
                total_amount, remarks
            ) VALUES (
                ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
            )
        ");
        
        // Type string: 23 characters total
        // 12 strings (s) + 9 decimals (d) + 2 strings (s)
        // ssssssssssss (ref_number to location_type = 12)
        // ddddddddd (expense_registration to expense_other = 9)
        // s (expense_other_description = 1)
        // d (total_amount = 1)
        // s (remarks = 1)
        // Total: 12s + 9d + 1s + 1d + 1s = 23
        
        $stmt->bind_param(
            "ssssssssssssddddddddsds",
            $ref_number,                 // 1  - string
            $employee_code,              // 2  - string
            $faculty_name,               // 3  - string
            $designation,                // 4  - string
            $pay_level,                  // 5  - string
            $department,                 // 6  - string
            $activity_nature,            // 7  - string
            $activity_name,              // 8  - string
            $activity_start_date,        // 9  - string (date)
            $activity_end_date,          // 10 - string (date)
            $activity_venue,             // 11 - string
            $location_type,              // 12 - string
            $expense_registration,       // 13 - decimal
            $expense_visa,               // 14 - decimal
            $expense_insurance,          // 15 - decimal
            $expense_air_fare,           // 16 - decimal
            $expense_local_travel,       // 17 - decimal
            $expense_da_per_diem,        // 18 - decimal
            $expense_boarding_lodging,   // 19 - decimal
            $expense_other,              // 20 - decimal
            $expense_other_description,  // 21 - string
            $total_amount,               // 22 - decimal
            $remarks                     // 23 - string
        );
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to submit form: " . $stmt->error);
        }
        
        $reimbursement_id = $conn->insert_id;
        $stmt->close();
        
        // Handle file uploads
        if (isset($_FILES['attachments']) && !empty($_FILES['attachments']['name'][0])) {
            
            $upload_dir = '../uploads/f5_attachments/';
            
            // Create directory if it doesn't exist
            if (!is_dir($upload_dir)) {
                mkdir($upload_dir, 0755, true);
            }
            
            $attachment_types = $_POST['attachment_types'] ?? [];
            $attachment_descriptions = $_POST['attachment_descriptions'] ?? [];
            
            $allowed_extensions = ['pdf', 'jpg', 'jpeg', 'png'];
            $max_file_size = 5 * 1024 * 1024; // 5MB
            
            for ($i = 0; $i < count($_FILES['attachments']['name']); $i++) {
                
                if ($_FILES['attachments']['error'][$i] === UPLOAD_ERR_OK) {
                    
                    $file_name = $_FILES['attachments']['name'][$i];
                    $file_tmp = $_FILES['attachments']['tmp_name'][$i];
                    $file_size = $_FILES['attachments']['size'][$i];
                    $file_type = $_FILES['attachments']['type'][$i];
                    
                    // Validate file size
                    if ($file_size > $max_file_size) {
                        throw new Exception("File $file_name exceeds 5MB limit.");
                    }
                    
                    // Validate file extension
                    $file_ext = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
                    if (!in_array($file_ext, $allowed_extensions)) {
                        throw new Exception("Invalid file type for $file_name. Only PDF, JPG, JPEG, PNG allowed.");
                    }
                    
                    // Generate unique filename
                    $new_file_name = $reimbursement_id . '_' . time() . '_' . $i . '.' . $file_ext;
                    $file_path = $upload_dir . $new_file_name;
                    
                    // Move uploaded file
                    if (move_uploaded_file($file_tmp, $file_path)) {
                        
                        $attachment_type = $attachment_types[$i] ?? 'OTHER';
                        $description = $attachment_descriptions[$i] ?? '';
                        
                        // Insert attachment record
                        $stmt_attach = $conn->prepare("
                            INSERT INTO f5_attachments (
                                reimbursement_id, attachment_type, file_name, file_path, 
                                file_size, file_type, description
                            ) VALUES (?, ?, ?, ?, ?, ?, ?)
                        ");
                        
                        // 7 parameters: i, s, s, s, i, s, s
                        $stmt_attach->bind_param(
                            "isssiss",
                            $reimbursement_id,   // integer
                            $attachment_type,    // string
                            $file_name,          // string
                            $file_path,          // string
                            $file_size,          // integer
                            $file_type,          // string
                            $description         // string
                        );
                        
                        if (!$stmt_attach->execute()) {
                            throw new Exception("Failed to save attachment info: " . $stmt_attach->error);
                        }
                        
                        $stmt_attach->close();
                        
                    } else {
                        throw new Exception("Failed to upload file: $file_name");
                    }
                }
            }
        }
        
        // Commit transaction
        $conn->commit();
        
        // Set success message
        $_SESSION['success_message'] = "F-5 Conference Reimbursement Form submitted successfully! Reference Number: $ref_number";
        header("Location: ../views/faculty_dashboard.php");
        exit();
        
    } catch (Exception $e) {
        // Rollback transaction on error
        $conn->rollback();
        
        $_SESSION['error_message'] = "Error: " . $e->getMessage();
        header("Location: ../views/form4_faculty.php");
        exit();
    }
    
} else {
    header("Location: ../views/form4_faculty.php");
    exit();
}
?>

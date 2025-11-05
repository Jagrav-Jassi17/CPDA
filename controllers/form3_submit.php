<?php
session_start();
if ($_SESSION['role'] !== 'faculty') {
    header("Location: ../login.php");
    exit();
}

include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    try {
        // Start transaction
        $conn->begin_transaction();
        
        // Get form data
        $employee_code = $_SESSION['employee_code'];
        $faculty_name = $_POST['faculty_name'];
        $designation = $_POST['designation'];
        $pay_level = $_POST['pay_level'];
        $department = $_POST['department'];
        
        // Set designation flags
        $designation_hag = ($designation === 'Professor (HAG)') ? 1 : 0;
        $designation_professor = ($designation === 'Professor') ? 1 : 0;
        $designation_associate_professor = ($designation === 'Associate Professor') ? 1 : 0;
        $designation_assistant_professor = ($designation === 'Assistant Professor') ? 1 : 0;
        
        // Get expense details
        $expense_books = floatval($_POST['expense_books'] ?? 0);
        $expense_stationary = floatval($_POST['expense_stationary'] ?? 0);
        $expense_patent = floatval($_POST['expense_patent'] ?? 0);
        $expense_computer_consumables = floatval($_POST['expense_computer_consumables'] ?? 0);
        $expense_consumables = floatval($_POST['expense_consumables'] ?? 0);
        $expense_synthesis_analysis = floatval($_POST['expense_synthesis_analysis'] ?? 0);
        
        // Get membership amounts
        $membership_amounts = $_POST['membership_amount'] ?? [];
        $total_membership = array_sum(array_map('floatval', $membership_amounts));
        
        // Calculate total amount
        $total_amount = $expense_books + $expense_stationary + $expense_patent + 
                       $expense_computer_consumables + $expense_consumables + 
                       $expense_synthesis_analysis + $total_membership;
        
        $remarks = $_POST['remarks'] ?? '';
        
        // Generate reference number
        $year = date('Y');
        $ref_query = "SELECT MAX(CAST(SUBSTRING_INDEX(ref_number, '/', -1) AS UNSIGNED)) as max_num 
                     FROM f4_reimbursement_applications 
                     WHERE ref_number LIKE 'F4/$year/%'";
        $ref_result = $conn->query($ref_query);
        $ref_row = $ref_result->fetch_assoc();
        $next_num = ($ref_row['max_num'] ?? 0) + 1;
        $ref_number = sprintf('F4/%s/%05d', $year, $next_num);
        
        // Insert main application
        $stmt = $conn->prepare("
            INSERT INTO f4_reimbursement_applications 
            (ref_number, employee_code, faculty_name, designation_hag, designation_professor, 
             designation_associate_professor, designation_assistant_professor, pay_level, department, 
             expense_books, expense_stationary, expense_patent, expense_computer_consumables, 
             expense_consumables, expense_synthesis_analysis, total_amount, remarks, 
             application_status, submission_date)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'SUBMITTED', NOW())
        ");
        
        $stmt->bind_param(
            "sisiiiiisddddddds",
            $ref_number,
            $employee_code,
            $faculty_name,
            $designation_hag,
            $designation_professor,
            $designation_associate_professor,
            $designation_assistant_professor,
            $pay_level,
            $department,
            $expense_books,
            $expense_stationary,
            $expense_patent,
            $expense_computer_consumables,
            $expense_consumables,
            $expense_synthesis_analysis,
            $total_amount,
            $remarks
        );
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to insert application: " . $stmt->error);
        }
        
        $application_id = $conn->insert_id;
        $stmt->close();
        
        // Insert professional memberships
        if (!empty($_POST['membership_body_name'])) {
            $membership_names = $_POST['membership_body_name'];
            $membership_amounts = $_POST['membership_amount'];
            $membership_types = $_POST['membership_type'];
            
            $stmt_membership = $conn->prepare("
                INSERT INTO f4_professional_memberships 
                (application_id, professional_body_name, membership_amount, membership_type)
                VALUES (?, ?, ?, ?)
            ");
            
            for ($i = 0; $i < count($membership_names); $i++) {
                if (!empty($membership_names[$i])) {
                    $body_name = $membership_names[$i];
                    $amount = floatval($membership_amounts[$i]);
                    $type = $membership_types[$i];
                    
                    $stmt_membership->bind_param("isds", $application_id, $body_name, $amount, $type);
                    
                    if (!$stmt_membership->execute()) {
                        throw new Exception("Failed to insert membership: " . $stmt_membership->error);
                    }
                }
            }
            $stmt_membership->close();
        }
        
        // Handle file uploads - FIXED VERSION
        if (!empty($_FILES['attachments']['name'][0])) {
            $upload_dir = '../uploads/f4/' . $year . '/';
            
            // Create directory if not exists
            if (!is_dir($upload_dir)) {
                mkdir($upload_dir, 0777, true);
            }
            
            $attachment_types = $_POST['attachment_types'] ?? [];
            $attachment_descriptions = $_POST['attachment_descriptions'] ?? [];
            
            $stmt_attachment = $conn->prepare("
                INSERT INTO f4_reimbursement_attachments 
                (application_id, attachment_type, file_name, file_path, file_size, file_type, description, uploaded_by)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ");
            
            for ($i = 0; $i < count($_FILES['attachments']['name']); $i++) {
                if ($_FILES['attachments']['error'][$i] === UPLOAD_ERR_OK) {
                    $file_name = $_FILES['attachments']['name'][$i];
                    $file_tmp = $_FILES['attachments']['tmp_name'][$i];
                    $file_size = $_FILES['attachments']['size'][$i];
                    $file_type = $_FILES['attachments']['type'][$i];
                    
                    // Generate unique filename
                    $file_extension = pathinfo($file_name, PATHINFO_EXTENSION);
                    $safe_ref = str_replace('/', '_', $ref_number); // Make filename safe
                    $unique_filename = $safe_ref . '_' . time() . '_' . $i . '.' . $file_extension;
                    $file_path = $upload_dir . $unique_filename;
                    
                    if (move_uploaded_file($file_tmp, $file_path)) {
                        $attachment_type = $attachment_types[$i] ?? 'OTHER';
                        $description = $attachment_descriptions[$i] ?? '';
                        
                        // FIXED: Changed bind_param to "isssisss" (note the 'i' for file_size)
                        $stmt_attachment->bind_param(
                            "isssisss",
                            $application_id,      // i - integer
                            $attachment_type,     // s - string
                            $file_name,          // s - string
                            $file_path,          // s - string
                            $file_size,          // i - integer (THIS WAS THE BUG!)
                            $file_type,          // s - string
                            $description,        // s - string
                            $employee_code       // s - string
                        );
                        
                        if (!$stmt_attachment->execute()) {
                            throw new Exception("Failed to insert attachment: " . $stmt_attachment->error);
                        }
                    } else {
                        throw new Exception("Failed to upload file: $file_name");
                    }
                }
            }
            $stmt_attachment->close();
        }
        
        // Commit transaction
        $conn->commit();
        
        // Success - redirect with success message
        $_SESSION['success_message'] = "Application submitted successfully! Application Number: " . $ref_number;
        header("Location: ../views/faculty_dashboard.php?ref=" . $ref_number);
        exit();
        
    } catch (Exception $e) {
        // Rollback on error
        $conn->rollback();
        $_SESSION['error_message'] = "Error submitting form: " . $e->getMessage();
        header("Location: ../views/form3_faculty.php");
        exit();
    }
    
} else {
    header("Location: ../views/form3_faculty.php");
    exit();
}
?>

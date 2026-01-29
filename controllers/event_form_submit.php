<?php
session_start();
if ($_SESSION['role'] !== 'faculty') {
    header("Location: ../login.php");
    exit();
}

include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    try {
        $conn->begin_transaction();
        
        // Sanitize and validate input
        $employee_code = $conn->real_escape_string($_POST['employee_code']);
        $faculty_name = $conn->real_escape_string($_POST['faculty_name']);
        
        // Process designation checkboxes
        $designation_hag = isset($_POST['designation']) && in_array('PROFESSOR_HAG', $_POST['designation']) ? 1 : 0;
        $designation_professor = isset($_POST['designation']) && in_array('PROFESSOR', $_POST['designation']) ? 1 : 0;
        $designation_associate_professor = isset($_POST['designation']) && in_array('ASSOCIATE_PROFESSOR', $_POST['designation']) ? 1 : 0;
        $designation_assistant_professor = isset($_POST['designation']) && in_array('ASSISTANT_PROFESSOR', $_POST['designation']) ? 1 : 0;
        
        $pay_level = $conn->real_escape_string($_POST['pay_level']);
        $department = $conn->real_escape_string($_POST['department']);
        $date_of_joining = $conn->real_escape_string($_POST['date_of_joining']);
        
        // Event details
        $nature_of_event = $conn->real_escape_string($_POST['nature_of_event']);
        $title_of_event = $conn->real_escape_string($_POST['title_of_event']);
        $period_of_event = $conn->real_escape_string($_POST['period_of_event']);
        $working_days_involved = intval($_POST['working_days_involved']);
        $venue_of_event = $conn->real_escape_string($_POST['venue_of_event']);
        $location = $conn->real_escape_string($_POST['location']);
        
        // Paper details
        $paper_title = isset($_POST['paper_title']) ? $conn->real_escape_string($_POST['paper_title']) : '';
        $paper_authors = isset($_POST['paper_authors']) ? $conn->real_escape_string($_POST['paper_authors']) : '';
        $no_objection_details = isset($_POST['no_objection_details']) ? $conn->real_escape_string($_POST['no_objection_details']) : '';
        
        // Expenses
        $expense_registration_fee = floatval($_POST['expense_registration_fee']);
        $expense_visa_fee = floatval($_POST['expense_visa_fee']);
        $expense_insurance_fee = floatval($_POST['expense_insurance_fee']);
        $expense_air_fare = floatval($_POST['expense_air_fare']);
        $expense_local_travel = floatval($_POST['expense_local_travel']);
        $expense_da_per_diem = floatval($_POST['expense_da_per_diem']);
        $expense_boarding_lodging = floatval($_POST['expense_boarding_lodging']);
        $expense_other_details = isset($_POST['expense_other_details']) ? $conn->real_escape_string($_POST['expense_other_details']) : '';
        $expense_other_amount = floatval($_POST['expense_other_amount']);
        $expense_total = floatval($_POST['expense_total']);
        
        // Holiday period
        $event_during_holidays = $conn->real_escape_string($_POST['event_during_holidays']);
        
        // Previous abroad participation
        $attended_abroad_current_block = $conn->real_escape_string($_POST['attended_abroad_current_block']);
        $previous_event_name = isset($_POST['previous_event_name']) ? $conn->real_escape_string($_POST['previous_event_name']) : '';
        $previous_event_dates = isset($_POST['previous_event_dates']) ? $conn->real_escape_string($_POST['previous_event_dates']) : '';
        $previous_event_venues = isset($_POST['previous_event_venues']) ? $conn->real_escape_string($_POST['previous_event_venues']) : '';
        
        // Generate application number
        $year_suffix = date('y');
        $app_num_query = "SELECT MAX(CAST(SUBSTRING(ref_number, -6) AS UNSIGNED)) as max_num 
                          FROM cpda_event_applications 
                          WHERE ref_number LIKE 'CPDA-EVT-$year_suffix-%'";
        $result = $conn->query($app_num_query);
        $row = $result->fetch_assoc();
        $next_num = ($row['max_num'] ?? 0) + 1;
        $ref_number = 'CPDA-EVT-' . $year_suffix . '-' . str_pad($next_num, 6, '0', STR_PAD_LEFT);
        
        // Insert main application
        $sql = "INSERT INTO cpda_event_applications (
            ref_number,
            employee_code,
            faculty_name,
            designation_hag,
            designation_professor,
            designation_associate_professor,
            designation_assistant_professor,
            pay_level,
            department,
            date_of_joining,
            nature_of_event,
            title_of_event,
            period_of_event,
            working_days_involved,
            venue_of_event,
            location,
            paper_title,
            paper_authors,
            no_objection_details,
            expense_registration_fee,
            expense_visa_fee,
            expense_insurance_fee,
            expense_air_fare,
            expense_local_travel,
            expense_da_per_diem,
            expense_boarding_lodging,
            expense_other_details,
            expense_other_amount,
            expense_total,
            event_during_holidays,
            attended_abroad_current_block,
            previous_event_name,
            previous_event_dates,
            previous_event_venues,
            application_status,
            current_stage,
            submission_date
        ) VALUES (
            '$ref_number',
            '$employee_code',
            '$faculty_name',
            $designation_hag,
            $designation_professor,
            $designation_associate_professor,
            $designation_assistant_professor,
            '$pay_level',
            '$department',
            '$date_of_joining',
            '$nature_of_event',
            '$title_of_event',
            '$period_of_event',
            $working_days_involved,
            '$venue_of_event',
            '$location',
            '$paper_title',
            '$paper_authors',
            '$no_objection_details',
            $expense_registration_fee,
            $expense_visa_fee,
            $expense_insurance_fee,
            $expense_air_fare,
            $expense_local_travel,
            $expense_da_per_diem,
            $expense_boarding_lodging,
            '$expense_other_details',
            $expense_other_amount,
            $expense_total,
            '$event_during_holidays',
            '$attended_abroad_current_block',
            '$previous_event_name',
            '$previous_event_dates',
            '$previous_event_venues',
            'SUBMITTED',
            'HOD_REVIEW',
            NOW()
        )";
        
        if (!$conn->query($sql)) {
            throw new Exception("Error inserting application: " . $conn->error);
        }
        
        $application_id = $conn->insert_id;
        
        // Handle file uploads
        $upload_dir = '../uploads/cpda_events/';
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0755, true);
        }
        
        // Handle abstract file upload (if provided)
        if (isset($_FILES['abstract_file']) && $_FILES['abstract_file']['error'] === UPLOAD_ERR_OK) {
            $file_name = basename($_FILES['abstract_file']['name']);
            $file_tmp = $_FILES['abstract_file']['tmp_name'];
            $file_size = $_FILES['abstract_file']['size'];
            $file_type = $_FILES['abstract_file']['type'];
            
            // Generate unique filename
            $file_ext = pathinfo($file_name, PATHINFO_EXTENSION);
            $unique_filename = $ref_number . '_abstract_' . time() . '.' . $file_ext;
            $file_path = $upload_dir . $unique_filename;
            
            if (move_uploaded_file($file_tmp, $file_path)) {
                // Update application with abstract path
                $conn->query("UPDATE cpda_event_applications SET abstract_attachment = '$unique_filename' WHERE application_id = $application_id");
                
                // Insert into attachments table
                $attach_sql = "INSERT INTO cpda_event_attachments (
                    application_id, 
                    attachment_type, 
                    file_name, 
                    file_path, 
                    file_size, 
                    file_type, 
                    uploaded_by
                ) VALUES (
                    $application_id,
                    'ABSTRACT',
                    '$file_name',
                    '$unique_filename',
                    $file_size,
                    '$file_type',
                    '$employee_code'
                )";
                $conn->query($attach_sql);
            }
        }
        
        // Handle institute arrangement document (if provided)
        if (isset($_FILES['arrangement_file']) && $_FILES['arrangement_file']['error'] === UPLOAD_ERR_OK) {
            $file_name = basename($_FILES['arrangement_file']['name']);
            $file_tmp = $_FILES['arrangement_file']['tmp_name'];
            $file_size = $_FILES['arrangement_file']['size'];
            $file_type = $_FILES['arrangement_file']['type'];
            
            $file_ext = pathinfo($file_name, PATHINFO_EXTENSION);
            $unique_filename = $ref_number . '_arrangement_' . time() . '.' . $file_ext;
            $file_path = $upload_dir . $unique_filename;
            
            if (move_uploaded_file($file_tmp, $file_path)) {
                // Update application with arrangement path
                $conn->query("UPDATE cpda_event_applications SET institute_arrangement_attachment = '$unique_filename' WHERE application_id = $application_id");
                
                // Insert into attachments table
                $attach_sql = "INSERT INTO cpda_event_attachments (
                    application_id, 
                    attachment_type, 
                    file_name, 
                    file_path, 
                    file_size, 
                    file_type, 
                    uploaded_by
                ) VALUES (
                    $application_id,
                    'INSTITUTE_ARRANGEMENT',
                    '$file_name',
                    '$unique_filename',
                    $file_size,
                    '$file_type',
                    '$employee_code'
                )";
                $conn->query($attach_sql);
            }
        }
        
        $conn->commit();
        
        $_SESSION['success_message'] = "Application submitted successfully! Application Number: " . $ref_number;
        header("Location: ../views/faculty_dashboard.php");
        exit();
        
    } catch (Exception $e) {
        $conn->rollback();
        $_SESSION['error_message'] = "Error submitting application: " . $e->getMessage();
        header("Location: ../views/cpda_event_form.php");
        exit();
    }
    
} else {
    header("Location: ../views/cpda_event_form.php");
    exit();
}
?>

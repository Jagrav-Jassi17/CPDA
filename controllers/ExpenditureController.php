<?php
session_start();
include_once '../config/db.php';

if (!in_array($_SESSION['role'], ['accounts_da','accounts_supp','accounts_ar'])) {
    header("Location: ../views/login.php"); exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') { 
    header("Location: ../views/accounts_da_dashboard.php"); 
    exit(); 
}

// Debug: Log POST data
error_log("POST Data: " . print_r($_POST, true));

$application_id = $_POST['application_id'] ?? '';
$employee_code = $conn->real_escape_string($_POST['employee_code'] ?? '');
$created_by = $_SESSION['employee_code'] ?? $_SESSION['name'] ?? null;
$action = $_POST['action'] ?? 'save_da';

if (!$application_id) {
    error_log("No application ID provided");
    die("Invalid application ID");
}

// Begin transaction
$conn->begin_transaction();

try {
    // Check if record exists in fdx_expenditure_main
    $check = $conn->prepare("SELECT Application_ID FROM fdx_expenditure_main WHERE Application_ID = ?");
    $check->bind_param("s", $application_id);
    $check->execute();
    $exists = $check->get_result()->fetch_assoc();

    // Extract values from POST with corrected field names matching the form
    // Point 1: Conferences (3 years)
    $p1_y1_num = intval($_POST['P1_Conferences_Y1_Num_Events'] ?? 0);
    $p1_y1_spent = floatval($_POST['P1_Conferences_Y1_Amt_Spent'] ?? 0);
    $p1_y1_comm = floatval($_POST['P1_Conferences_Y1_Amt_Committed'] ?? 0);
    $p1_y1_bal = floatval($_POST['P1_Conferences_Y1_Balance'] ?? 0);
    
    $p1_y2_num = intval($_POST['P1_Conferences_Y2_Num_Events'] ?? 0);
    $p1_y2_spent = floatval($_POST['P1_Conferences_Y2_Amt_Spent'] ?? 0);
    $p1_y2_comm = floatval($_POST['P1_Conferences_Y2_Amt_Committed'] ?? 0);
    $p1_y2_bal = floatval($_POST['P1_Conferences_Y2_Balance'] ?? 0);
    
    $p1_y3_num = intval($_POST['P1_Conferences_Y3_Num_Events'] ?? 0);
    $p1_y3_spent = floatval($_POST['P1_Conferences_Y3_Amt_Spent'] ?? 0);
    $p1_y3_comm = floatval($_POST['P1_Conferences_Y3_Amt_Committed'] ?? 0);
    $p1_y3_bal = floatval($_POST['P1_Conferences_Y3_Balance'] ?? 0);
    
    // Point 2: Memberships (3 years)
    $p2_y1_num = intval($_POST['P2_Membership_Y1_Num_Availed'] ?? 0);
    $p2_y1_spent = floatval($_POST['P2_Membership_Y1_Amt_Spent'] ?? 0);
    $p2_y1_comm = floatval($_POST['P2_Membership_Y1_Amt_Committed'] ?? 0);
    $p2_y1_bal = floatval($_POST['P2_Membership_Y1_Balance'] ?? 0);
    
    $p2_y2_num = intval($_POST['P2_Membership_Y2_Num_Availed'] ?? 0);
    $p2_y2_spent = floatval($_POST['P2_Membership_Y2_Amt_Spent'] ?? 0);
    $p2_y2_comm = floatval($_POST['P2_Membership_Y2_Amt_Committed'] ?? 0);
    $p2_y2_bal = floatval($_POST['P2_Membership_Y2_Balance'] ?? 0);
    
    $p2_y3_num = intval($_POST['P2_Membership_Y3_Num_Availed'] ?? 0);
    $p2_y3_spent = floatval($_POST['P2_Membership_Y3_Amt_Spent'] ?? 0);
    $p2_y3_comm = floatval($_POST['P2_Membership_Y3_Amt_Committed'] ?? 0);
    $p2_y3_bal = floatval($_POST['P2_Membership_Y3_Balance'] ?? 0);
    
    // Point 3: Contingent Expenses (5 categories)
    $p3a_num = intval($_POST['P3a_Consumables_Num_Availed'] ?? 0);
    $p3a_spent = floatval($_POST['P3a_Consumables_Amt_Spent'] ?? 0);
    $p3a_comm = floatval($_POST['P3a_Consumables_Amt_Committed'] ?? 0);
    $p3a_bal = floatval($_POST['P3a_Consumables_Balance'] ?? 0);
    
    $p3b_num = intval($_POST['P3b_Synthesis_Testing_Num_Availed'] ?? 0);
    $p3b_spent = floatval($_POST['P3b_Synthesis_Testing_Amt_Spent'] ?? 0);
    $p3b_comm = floatval($_POST['P3b_Synthesis_Testing_Amt_Committed'] ?? 0);
    $p3b_bal = floatval($_POST['P3b_Synthesis_Testing_Balance'] ?? 0);
    
    $p3c_i_num = intval($_POST['P3c_i_Stationary_Num_Availed'] ?? 0);
    $p3c_i_spent = floatval($_POST['P3c_i_Stationary_Amt_Spent'] ?? 0);
    $p3c_i_comm = floatval($_POST['P3c_i_Stationary_Amt_Committed'] ?? 0);
    $p3c_i_bal = floatval($_POST['P3c_i_Stationary_Balance'] ?? 0);
    
    $p3c_ii_num = intval($_POST['P3c_ii_Books_Num_Availed'] ?? 0);
    $p3c_ii_spent = floatval($_POST['P3c_ii_Books_Amt_Spent'] ?? 0);
    $p3c_ii_comm = floatval($_POST['P3c_ii_Books_Amt_Committed'] ?? 0);
    $p3c_ii_bal = floatval($_POST['P3c_ii_Books_Balance'] ?? 0);
    
    $p3d_num = intval($_POST['P3d_Computer_Consumables_Num_Availed'] ?? 0);
    $p3d_spent = floatval($_POST['P3d_Computer_Consumables_Amt_Spent'] ?? 0);
    $p3d_comm = floatval($_POST['P3d_Computer_Consumables_Amt_Committed'] ?? 0);
    $p3d_bal = floatval($_POST['P3d_Computer_Consumables_Balance'] ?? 0);

    if ($exists) {
        // UPDATE existing record
        $sql = "UPDATE fdx_expenditure_main SET 
            P1_Conferences_Y1_2021_22_Num_Events = ?,
            P1_Conferences_Y1_2021_22_Amt_Spent = ?,
            P1_Conferences_Y1_2021_22_Amt_Committed = ?,
            P1_Conferences_Y1_2021_22_Balance = ?,
            
            P1_Conferences_Y2_2022_23_Num_Events = ?,
            P1_Conferences_Y2_2022_23_Amt_Spent = ?,
            P1_Conferences_Y2_2022_23_Amt_Committed = ?,
            P1_Conferences_Y2_2022_23_Balance = ?,
            
            P1_Conferences_Y3_2023_24_Num_Events = ?,
            P1_Conferences_Y3_2023_24_Amt_Spent = ?,
            P1_Conferences_Y3_2023_24_Amt_Committed = ?,
            P1_Conferences_Y3_2023_24_Balance = ?,
            
            P2_Membership_Y1_2021_22_Num_Availed = ?,
            P2_Membership_Y1_2021_22_Amt_Spent = ?,
            P2_Membership_Y1_2021_22_Amt_Committed = ?,
            P2_Membership_Y1_2021_22_Balance = ?,
            
            P2_Membership_Y2_2022_23_Num_Availed = ?,
            P2_Membership_Y2_2022_23_Amt_Spent = ?,
            P2_Membership_Y2_2022_23_Amt_Committed = ?,
            P2_Membership_Y2_2022_23_Balance = ?,
            
            P2_Membership_Y3_2023_24_Num_Availed = ?,
            P2_Membership_Y3_2023_24_Amt_Spent = ?,
            P2_Membership_Y3_2023_24_Amt_Committed = ?,
            P2_Membership_Y3_2023_24_Balance = ?,
            
            P3a_Consumables_Num_Availed = ?,
            P3a_Consumables_Amt_Spent = ?,
            P3a_Consumables_Amt_Committed = ?,
            P3a_Consumables_Balance = ?,
            
            P3b_Synthesis_Testing_Num_Availed = ?,
            P3b_Synthesis_Testing_Amt_Spent = ?,
            P3b_Synthesis_Testing_Amt_Committed = ?,
            P3b_Synthesis_Testing_Balance = ?,
            
            P3c_i_Stationary_Num_Availed = ?,
            P3c_i_Stationary_Amt_Spent = ?,
            P3c_i_Stationary_Amt_Committed = ?,
            P3c_i_Stationary_Balance = ?,
            
            P3c_ii_Books_Num_Availed = ?,
            P3c_ii_Books_Amt_Spent = ?,
            P3c_ii_Books_Amt_Committed = ?,
            P3c_ii_Books_Balance = ?,
            
            P3d_Computer_Consumables_Num_Availed = ?,
            P3d_Computer_Consumables_Amt_Spent = ?,
            P3d_Computer_Consumables_Amt_Committed = ?,
            P3d_Computer_Consumables_Balance = ?,
            
            Updated_At = NOW()
            WHERE Application_ID = ?";
        
        $stmt = $conn->prepare($sql);
        
        if (!$stmt) {
            throw new Exception("Prepare failed: " . $conn->error);
        }
        
        // Bind all 44 values + application_id
        $stmt->bind_param("iddddiddddiddddiddddiddddiddddiddddiddddiddds",
            $p1_y1_num, $p1_y1_spent, $p1_y1_comm, $p1_y1_bal,
            $p1_y2_num, $p1_y2_spent, $p1_y2_comm, $p1_y2_bal,
            $p1_y3_num, $p1_y3_spent, $p1_y3_comm, $p1_y3_bal,
            $p2_y1_num, $p2_y1_spent, $p2_y1_comm, $p2_y1_bal,
            $p2_y2_num, $p2_y2_spent, $p2_y2_comm, $p2_y2_bal,
            $p2_y3_num, $p2_y3_spent, $p2_y3_comm, $p2_y3_bal,
            $p3a_num, $p3a_spent, $p3a_comm, $p3a_bal,
            $p3b_num, $p3b_spent, $p3b_comm, $p3b_bal,
            $p3c_i_num, $p3c_i_spent, $p3c_i_comm, $p3c_i_bal,
            $p3c_ii_num, $p3c_ii_spent, $p3c_ii_comm, $p3c_ii_bal,
            $p3d_num, $p3d_spent, $p3d_comm, $p3d_bal,
            $application_id
        );
        
    } else {
        // INSERT new record
        $sql = "INSERT INTO fdx_expenditure_main (
            Application_ID,
            P1_Conferences_Y1_2021_22_Num_Events, P1_Conferences_Y1_2021_22_Amt_Spent, 
            P1_Conferences_Y1_2021_22_Amt_Committed, P1_Conferences_Y1_2021_22_Balance,
            
            P1_Conferences_Y2_2022_23_Num_Events, P1_Conferences_Y2_2022_23_Amt_Spent, 
            P1_Conferences_Y2_2022_23_Amt_Committed, P1_Conferences_Y2_2022_23_Balance,
            
            P1_Conferences_Y3_2023_24_Num_Events, P1_Conferences_Y3_2023_24_Amt_Spent, 
            P1_Conferences_Y3_2023_24_Amt_Committed, P1_Conferences_Y3_2023_24_Balance,
            
            P2_Membership_Y1_2021_22_Num_Availed, P2_Membership_Y1_2021_22_Amt_Spent, 
            P2_Membership_Y1_2021_22_Amt_Committed, P2_Membership_Y1_2021_22_Balance,
            
            P2_Membership_Y2_2022_23_Num_Availed, P2_Membership_Y2_2022_23_Amt_Spent, 
            P2_Membership_Y2_2022_23_Amt_Committed, P2_Membership_Y2_2022_23_Balance,
            
            P2_Membership_Y3_2023_24_Num_Availed, P2_Membership_Y3_2023_24_Amt_Spent, 
            P2_Membership_Y3_2023_24_Amt_Committed, P2_Membership_Y3_2023_24_Balance,
            
            P3a_Consumables_Num_Availed, P3a_Consumables_Amt_Spent, 
            P3a_Consumables_Amt_Committed, P3a_Consumables_Balance,
            
            P3b_Synthesis_Testing_Num_Availed, P3b_Synthesis_Testing_Amt_Spent, 
            P3b_Synthesis_Testing_Amt_Committed, P3b_Synthesis_Testing_Balance,
            
            P3c_i_Stationary_Num_Availed, P3c_i_Stationary_Amt_Spent, 
            P3c_i_Stationary_Amt_Committed, P3c_i_Stationary_Balance,
            
            P3c_ii_Books_Num_Availed, P3c_ii_Books_Amt_Spent, 
            P3c_ii_Books_Amt_Committed, P3c_ii_Books_Balance,
            
            P3d_Computer_Consumables_Num_Availed, P3d_Computer_Consumables_Amt_Spent, 
            P3d_Computer_Consumables_Amt_Committed, P3d_Computer_Consumables_Balance
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        $stmt = $conn->prepare($sql);
        
        if (!$stmt) {
            throw new Exception("Prepare failed: " . $conn->error);
        }
        
        // Bind application_id + 44 values
        $stmt->bind_param("siddddiddddiddddiddddiddddiddddiddddiddddiddd",
            $application_id,
            $p1_y1_num, $p1_y1_spent, $p1_y1_comm, $p1_y1_bal,
            $p1_y2_num, $p1_y2_spent, $p1_y2_comm, $p1_y2_bal,
            $p1_y3_num, $p1_y3_spent, $p1_y3_comm, $p1_y3_bal,
            $p2_y1_num, $p2_y1_spent, $p2_y1_comm, $p2_y1_bal,
            $p2_y2_num, $p2_y2_spent, $p2_y2_comm, $p2_y2_bal,
            $p2_y3_num, $p2_y3_spent, $p2_y3_comm, $p2_y3_bal,
            $p3a_num, $p3a_spent, $p3a_comm, $p3a_bal,
            $p3b_num, $p3b_spent, $p3b_comm, $p3b_bal,
            $p3c_i_num, $p3c_i_spent, $p3c_i_comm, $p3c_i_bal,
            $p3c_ii_num, $p3c_ii_spent, $p3c_ii_comm, $p3c_ii_bal,
            $p3d_num, $p3d_spent, $p3d_comm, $p3d_bal
        );
    }
    
    if (!$stmt->execute()) {
        throw new Exception("Execute failed: " . $stmt->error);
    }
    
    error_log("Main expenditure data saved successfully");
    
    // Handle Electronic Devices
    // First, delete existing devices for this application
    $del = $conn->prepare("DELETE FROM fdx_electronic_devices WHERE Application_ID = ?");
    $del->bind_param("s", $application_id);
    $del->execute();
    
    // Insert new devices
    if (!empty($_POST['devices']) && is_array($_POST['devices'])) {
        $device_stmt = $conn->prepare("INSERT INTO fdx_electronic_devices 
            (Application_ID, S_No, Item_Description, Date_of_Issue, Cost_at_Time_of_Issue) 
            VALUES (?, ?, ?, ?, ?)");
        
        if (!$device_stmt) {
            throw new Exception("Device prepare failed: " . $conn->error);
        }
        
        foreach ($_POST['devices'] as $d) {
            $s_no = trim($d['S_No'] ?? '');
            $item_desc = trim($d['Item_Description'] ?? '');
            
            // Skip empty rows
            if ($item_desc === '' && $s_no === '') continue;
            
            $date_of_issue = !empty($d['Date_of_Issue']) ? $d['Date_of_Issue'] : null;
            $cost = floatval($d['Cost_at_Time_of_Issue'] ?? 0);
            
            $device_stmt->bind_param("ssssd", 
                $application_id, 
                $s_no, 
                $item_desc, 
                $date_of_issue, 
                $cost
            );
            
            if (!$device_stmt->execute()) {
                error_log("Device insert failed: " . $device_stmt->error);
            }
        }
        
        error_log("Devices saved successfully");
    }
    
    // If action is forward, update application stage and insert approval workflow entry
    if ($action === 'save_and_forward') {
        // Update application status
        $upd = $conn->prepare("UPDATE cpda_applications 
            SET current_stage = 'ACCOUNTS_SUPDT_REVIEW', 
                status = 'ACCOUNTS_REVIEW', 
                updated_at = NOW() 
            WHERE application_id = ?");
        $upd->bind_param("s", $application_id);
        
        if (!$upd->execute()) {
            error_log("Application update failed: " . $upd->error);
        }
        
        // Insert workflow record
        $ins = $conn->prepare("INSERT INTO approval_workflow 
            (application_id, approver_role, approver_name, action, comments, action_date, signature_captured) 
            VALUES (?, 'DEALING_ASSISTANT', ?, 'BALANCE_CONFIRMED', ?, NOW(), 0)");
        
        $approver_name = $_SESSION['name'] ?? 'DA';
        $comments = 'Expenditure data saved by DA and forwarded to Superintendent';
        
        $ins->bind_param("sss", $application_id, $approver_name, $comments);
        
        if (!$ins->execute()) {
            error_log("Workflow insert failed: " . $ins->error);
        }
        
        error_log("Application forwarded to Superintendent");
    }
    
    // Commit transaction
    $conn->commit();
    error_log("Transaction committed successfully");
    
    $redirect_msg = ($action === 'save_and_forward') ? 'success_forwarded' : 'success';
    header("Location: ../views/accounts_da_dashboard.php?{$redirect_msg}=1");
    exit();
    
} catch (Exception $e) {
    // Rollback on error
    $conn->rollback();
    error_log("Expenditure Controller Error: " . $e->getMessage());
    error_log("Stack trace: " . $e->getTraceAsString());
    die("Error saving data: " . $e->getMessage());
}
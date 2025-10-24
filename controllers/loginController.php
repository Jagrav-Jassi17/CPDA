<?php
session_start();
include_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password']; // for testing (we’ll replace with bcrypt later)

    $sql = "SELECT * FROM users WHERE email = ? AND password = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $email, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();
        $_SESSION['employee_code'] = $user['employee_code'];
        $_SESSION['name'] = $user['name'];
        $_SESSION['role'] = $user['role'];
        $_SESSION['department'] = $user['department'];
        $_SESSION['email'] = $user['email'];
        $_SESSION['mobile_number'] = $user['mobile_number'];
        $_SESSION['pay_level'] = $user['pay_level'];
        $_SESSION['date_of_joining'] = $user['date_of_joining'];
        // Corrected Code
        switch ($user['role']) {
            case 'faculty':
                header("Location: ../views/faculty_dashboard.php");
                break;
            case 'hod':
                header("Location: ../views/hod_dashboard.php");
                break;
            case 'accounts_ar':
                header("Location: ../views/accounts_ar_dashboard.php");
                break;
            case 'accounts_supp.': // Note: Standardized role was 'accounts_supp', check your data for consistency
                header("Location: ../views/accounts_supp_dashboard.php");
                break;
            case 'accounts_da':
                header("Location: ../views/accounts_da_dashboard.php");
                break;
            case 'assoc_dean_fw':
                header("Location: ../views/assoc_dean_fw_dashboard.php");
                break;
            case 'dean_fw':
                header("Location: ../views/dean_fw_dashboard.php");
                break;
            case 'dfw_da':
                header("Location: ../views/dfw_da_dashboard.php");
                break;
            case 'director':
                header("Location: ../views/director_dashboard.php");
                break;
            default:
                echo "Invalid user role!";
        }
    } else {
        echo "<script>alert('Invalid email or password'); window.location.href='../views/login.php';</script>";
    }
}
?>

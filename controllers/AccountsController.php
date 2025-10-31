<?php
include_once __DIR__ . '/../config/db.php';
include_once __DIR__ . '/../models/Expenditure.php';

$db = $conn;
$expenditure = new Expenditure($db);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = [
        'Application_ID' => $_POST['Application_ID'],
        'Conf_Num_Events' => $_POST['Conf_Num_Events'],
        'Conf_Amt_Spent' => $_POST['Conf_Amt_Spent'],
        'Conf_Amt_Committed' => $_POST['Conf_Amt_Committed'],
        'Conf_Balance' => $_POST['Conf_Balance']
    ];

    if ($expenditure->saveExpenditure($data)) {
        header("Location: ../views/accounts_success.php");
        exit();
    } else {
        echo "Error saving expenditure data.";
    }
}
?>

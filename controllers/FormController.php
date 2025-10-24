<?php
include('../config/db.php');
include('../models/PDAForm.php');

$form = new PDAForm($conn);

if (isset($_POST['submitForm'])) {
    $user_id ; // (Temporary: replace with session user_id)
    $total_requested = array_sum($_POST['membership_amount']) + array_sum($_POST['article_amount']);

    $data = [
        'user_id' => $user_id,
        'block_year_from' => $_POST['block_year_from'],
        'block_year_to' => $_POST['block_year_to'],
        'purpose' => $_POST['purpose'],
        'tech_spec' => $_POST['tech_spec'],
        'remarks' => $_POST['remarks'],
        'total_requested' => $total_requested
    ];

    if ($form->createForm($data)) {
        $form_id = $conn->insert_id;

        // Save membership data
        foreach ($_POST['membership_body'] as $i => $body) {
            $amount = $_POST['membership_amount'][$i];
            $conn->query("INSERT INTO cpda_memberships (form_id, professional_body, amount) 
                          VALUES ($form_id, '$body', '$amount')");
        }

        // Save consumables
        foreach ($_POST['article_name'] as $i => $name) {
            $amount = $_POST['article_amount'][$i];
            $conn->query("INSERT INTO cpda_consumables (form_id, article_name, amount) 
                          VALUES ($form_id, '$name', '$amount')");
        }

        echo "<script>alert('Form submitted successfully!'); window.location.href='../views/forms/form_pda_block.php';</script>";
    } else {
        echo "Error submitting form.";
    }
}
?>

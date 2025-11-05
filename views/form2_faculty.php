<?php
session_start();
if ($_SESSION['role'] !== 'faculty') {
    header("Location: login.php");
    exit();
}
include_once '../config/db.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CPDA Event Participation Form - Faculty</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px 40px; 
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 { 
            text-align: center; 
            color: #333;
            border-bottom: 2px solid #000;
            padding-bottom: 10px;
            margin-bottom: 30px;
        }
        .form-section {
            margin-bottom: 25px;
            border: 1px solid #ddd;
            padding: 15px;
            background: #fafafa;
        }
        .form-row {
            display: grid;
            grid-template-columns: 300px 1fr;
            margin-bottom: 15px;
            align-items: start;
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }
        .form-label {
            font-weight: bold;
            padding: 8px 10px;
            color: #333;
            display: flex;
            align-items: center;
        }
        .form-input {
            padding: 8px;
        }
        input[type="text"], 
        input[type="email"], 
        input[type="date"],
        input[type="number"],
        textarea, 
        select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        textarea {
            min-height: 60px;
            resize: vertical;
        }
        .checkbox-group {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .checkbox-item input[type="checkbox"] {
            width: auto;
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 10px; 
            background: white;
        }
        th, td { 
            border: 1px solid #ccc; 
            padding: 10px; 
            text-align: left; 
        }
        th {
            background-color: #f0f0f0;
            font-weight: bold;
        }
        .sub-section {
            margin-left: 20px;
            margin-top: 10px;
        }
        .btn-submit {
            background: #007bff;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            display: block;
            margin: 30px auto 0;
        }
        .btn-submit:hover {
            background: #0056b3;
        }
        .note {
            font-size: 12px;
            color: #666;
            font-style: italic;
            margin-top: 5px;
        }
        .expense-label {
            padding-left: 30px;
            font-weight: normal;
        }
        .radio-group {
            display: flex;
            gap: 20px;
        }
        .radio-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .radio-item input[type="radio"] {
            width: auto;
        }
        .nested-field {
            margin-left: 30px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>CPDA Event Participation Application Form</h2>

    <form method="POST" action="../controllers/event_form_submit.php" enctype="multipart/form-data">
        
        <!-- 1. Employee Code -->
        <div class="form-row">
            <div class="form-label">1. कर्मचारी कोड (स्माईल ईआरपी) / Employee Code (Smile ERP)</div>
            <div class="form-input">
                <input type="text" name="employee_code" value="<?= htmlspecialchars($_SESSION['employee_code'] ?? ''); ?>" required>
            </div>
        </div>

        <!-- 2. Faculty Name -->
        <div class="form-row">
            <div class="form-label">2. संकाय सदस्य का नाम / Name of Faculty Member</div>
            <div class="form-input">
                <input type="text" name="faculty_name" value="<?= htmlspecialchars($_SESSION['name'] ?? ''); ?>" required>
            </div>
        </div>

        <!-- 3. Designation -->
        <div class="form-row">
            <div class="form-label">3. पदनाम / Designation</div>
            <div class="form-input">
                <div class="checkbox-group">
                    <div class="checkbox-item">
                        <input type="checkbox" name="designation[]" value="PROFESSOR_HAG" id="prof_hag">
                        <label for="prof_hag">प्राध्यापक (एचएजी) / Professor (HAG)</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" name="designation[]" value="PROFESSOR" id="prof">
                        <label for="prof">प्राध्यापक / Professor</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" name="designation[]" value="ASSOCIATE_PROFESSOR" id="assoc_prof">
                        <label for="assoc_prof">सह-प्राध्यापक / Associate Professor</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" name="designation[]" value="ASSISTANT_PROFESSOR" id="asst_prof">
                        <label for="asst_prof">सहायक प्राध्यापक / Assistant Professor</label>
                    </div>
                </div>
            </div>
        </div>

        <!-- 4. Pay Level -->
        <div class="form-row">
            <div class="form-label">4. वेतन स्तर / Pay Level</div>
            <div class="form-input">
                <input type="text" name="pay_level" placeholder="वेतन स्तर / Pay Level 10, 11, 12, 13A2, 14A, 15" value="<?= htmlspecialchars($_SESSION['pay_level'] ?? ''); ?>" required>
            </div>
        </div>

        <!-- 5. Department -->
        <div class="form-row">
            <div class="form-label">5. विभाग / Department</div>
            <div class="form-input">
                <input type="text" name="department" value="<?= htmlspecialchars($_SESSION['department'] ?? ''); ?>" required>
            </div>
        </div>

        <!-- 6. Date of Joining -->
        <div class="form-row">
            <div class="form-label">6. नियुक्ति तिथि / Date of Joining (Initial/Present Post)</div>
            <div class="form-input">
                <input type="date" name="date_of_joining" value="<?= htmlspecialchars($_SESSION['date_of_joining'] ?? ''); ?>" required>
            </div>
        </div>

        <!-- 7. Nature of Event -->
        <div class="form-row">
            <div class="form-label">7. आयोजन की प्रकृति / Nature of event</div>
            <div class="form-input">
                <input type="text" name="nature_of_event" required>
            </div>
        </div>

        <!-- 8. Title of Event -->
        <div class="form-row">
            <div class="form-label">8. आयोजन शीर्षक / Title of event</div>
            <div class="form-input">
                <input type="text" name="title_of_event" required>
            </div>
        </div>

        <!-- 9. Period of Event -->
        <div class="form-row">
            <div class="form-label">9. आयोजन अवधि / Period of the event</div>
            <div class="form-input">
                <input type="text" name="period_of_event" placeholder="e.g., 15-20 Jan 2024" required>
            </div>
        </div>

        <!-- 10. No. of Working Days -->
        <div class="form-row">
            <div class="form-label">10. समाहित कार्य दिवस / No. of working days involved</div>
            <div class="form-input">
                <input type="number" name="working_days_involved" min="1" required>
            </div>
        </div>

        <!-- 11. Venue -->
        <div class="form-row">
            <div class="form-label">11. आयोजन स्थल / Venue of the event</div>
            <div class="form-input">
                <input type="text" name="venue_of_event" required>
            </div>
        </div>

        <!-- 12. Paper Details -->
        <div class="form-section">
            <div class="form-row">
                <div class="form-label">12. स्वीकृत पत्र का विवरण / Details of the accepted paper</div>
                <div class="form-input">
                    <div class="note">Please attach the abstract of the paper</div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-label">(a) पत्र शीर्षक / Title of the Paper</div>
                <div class="form-input">
                    <input type="text" name="paper_title">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label">(b) लेखक (प्रस्तुता) / Authors (as submitted)</div>
                <div class="form-input">
                    <textarea name="paper_authors"></textarea>
                </div>
            </div>

            <div class="form-row">
                <div class="form-label">(c) अन्य लेखक(रों) में से अनुमति प्राप्त पत्र / No objection from other authors</div>
                <div class="form-input">
                    <textarea name="no_objection_details" placeholder="Provide details if applicable"></textarea>
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-label">Paper Abstract (PDF/DOC)</div>
            <div class="form-input">
                <input type="file" name="abstract_file" accept=".pdf,.doc,.docx">
                <div class="note">Upload the abstract of your paper (Max 5MB)</div>
            </div>
        </div>
        <!-- 13. Details of Expenses -->
        <div class="form-section">
            <div class="form-row">
                <div class="form-label" style="font-size: 16px;">13. व्यय का विवरण (अनुमानित) / Details of Expenses (approximate)</div>
                <div class="form-input"></div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label">a) अतिरक्त शुल्क सहित पंजीकरण शुल्क / Registration fee including transaction charges</div>
                <div class="form-input">
                    <input type="number" name="expense_registration_fee" step="0.01" min="0" value="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label">b) वीजा शुल्क (यदि लागू हो) व वीजा संग्रह हेतु व्यय / Visa Fee (if applicable) and expenses for collection of Visa</div>
                <div class="form-input">
                    <input type="number" name="expense_visa_fee" step="0.01" min="0" value="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label">c) बीमा शुल्क (यदि लागू हो) / Insurance fee (if applicable)</div>
                <div class="form-input">
                    <input type="number" name="expense_insurance_fee" step="0.01" min="0" value="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label">d) टीए (हवाई यात्रा) / TA (Air Fare)</div>
                <div class="form-input">
                    <input type="number" name="expense_air_fare" step="0.01" min="0" value="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label">e) टीए (स्थानीय यात्रा) / TA (Local Travel)</div>
                <div class="form-input">
                    <input type="number" name="expense_local_travel" step="0.01" min="0" value="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label">f) अवधि के लिए डीए/प्रतिदिन / DA per diem</div>
                <div class="form-input">
                    <input type="number" name="expense_da_per_diem" step="0.01" min="0" value="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label">g) पात्रता अनुसार भोजन व आवास / Boarding & Lodging as per entitlement</div>
                <div class="form-input">
                    <input type="number" name="expense_boarding_lodging" step="0.01" min="0" value="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label">h) कोई अन्य व्यय (कृपया विवरण दें) / Any Other expenses (Please give detail)</div>
                <div class="form-input">
                    <textarea name="expense_other_details" rows="2"></textarea>
                    <input type="number" name="expense_other_amount" step="0.01" min="0" value="0" placeholder="Amount (₹)">
                </div>
            </div>

            <div class="form-row">
                <div class="form-label expense-label" style="font-weight: bold;">कुल (a से h) / Total (a to h)</div>
                <div class="form-input">
                    <input type="number" name="expense_total" step="0.01" min="0" value="0" readonly style="background: #f0f0f0; font-weight: bold;">
                </div>
            </div>
        </div>

        <!-- 14. Vacation Period Question -->
        <div class="form-section">
            <div class="form-row">
                <div class="form-label">14. क्या आयोजन अवकाश/छुट्टियों के दौरान है? / Does the event fall during vacations/holidays?</div>
                <div class="form-input">
                    <div class="radio-group">
                        <div class="radio-item">
                            <input type="radio" name="event_during_holidays" value="YES" id="holidays_yes" required>
                            <label for="holidays_yes">हाँ / Yes</label>
                        </div>
                        <div class="radio-item">
                            <input type="radio" name="event_during_holidays" value="NO" id="holidays_no" required>
                            <label for="holidays_no">नहीं / No</label>
                        </div>
                    </div>
                    <div class="note" style="margin-top: 10px;">
                        कृपया क्रमांक 8 में उल्लिखित अवधि के दौरान संस्थान की असाइनमेंट की व्यवस्था करें, यदि यह छुट्टियों के दौरान नहीं है।<br>
                        Please attach arrangement of Institute's assignments during the period mentioned at Sr.No.8 if it is not during holidays.
                    </div>
                </div>
            </div>
        </div>

        <div class="form-row" id="arrangement_upload" style="display:none;">
            <div class="form-label">Institute Arrangement Document</div>
            <div class="form-input">
                <input type="file" name="arrangement_file" accept=".pdf,.doc,.docx">
                <div class="note">Upload document showing Institute's assignment arrangements (Max 5MB)</div>
            </div>
        </div>
        <!-- 15. Programme Attended Abroad -->
        <div class="form-section">
            <div class="form-row">
                <div class="form-label">15. क्या आपने चालू सीपीडीए खंड अवधि के दौरान किसी विदेशी कार्यक्रम में भाग लिया है? / Have you attended any programme abroad during the current CPDA block period</div>
                <div class="form-input">
                    <div class="radio-group">
                        <div class="radio-item">
                            <input type="radio" name="attended_abroad_current_block" value="YES" id="abroad_yes">
                            <label for="abroad_yes">हाँ (अगर हाँ, तो कृपया निम्नलिखित विवरण प्रदान करें) / Yes/No (If yes, please provide the following detail)</label>
                        </div>
                        <div class="radio-item">
                            <input type="radio" name="attended_abroad_current_block" value="NO" id="abroad_no">
                            <label for="abroad_no">नहीं / No</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="nested-field">
                <div class="form-row">
                    <div class="form-label">(a) आयोजन का नाम / Name of the event(s)</div>
                    <div class="form-input">
                        <textarea name="previous_event_name" rows="2"></textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-label">(b) आयोजन तिथि / Date(s) of event</div>
                    <div class="form-input">
                        <input type="text" name="previous_event_dates" placeholder="e.g., 10-15 March 2024">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-label">(c) स्थान / Venue(s)</div>
                    <div class="form-input">
                        <input type="text" name="previous_event_venues">
                    </div>
                </div>
            </div>
        </div>

        <button type="submit" class="btn-submit">Submit Application</button>
    </form>
</div>

<script>
// Auto-calculate total expenses
document.addEventListener('DOMContentLoaded', function() {
    const expenseFields = [
        'expense_registration_fee',
        'expense_visa_fee',
        'expense_insurance_fee',
        'expense_air_fare',
        'expense_local_travel',
        'expense_da_per_diem',
        'expense_boarding_lodging',
        'expense_other_amount'
    ];

    function calculateTotal() {
        let total = 0;
        expenseFields.forEach(fieldName => {
            const field = document.getElementsByName(fieldName)[0];
            const value = parseFloat(field.value) || 0;
            total += value;
        });
        document.getElementsByName('expense_total')[0].value = total.toFixed(2);
    }

    expenseFields.forEach(fieldName => {
        const field = document.getElementsByName(fieldName)[0];
        field.addEventListener('input', calculateTotal);
    });

    // Show/hide previous event fields based on radio selection
    const abroadRadios = document.getElementsByName('attended_abroad_current_block');
    const nestedFields = document.querySelector('.nested-field');
    
    abroadRadios.forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.value === 'YES') {
                nestedFields.style.display = 'block';
            } else {
                nestedFields.style.display = 'none';
            }
        });
    });
    // Show/hide arrangement file upload
    const holidayRadios = document.getElementsByName('event_during_holidays');
    const arrangementUpload = document.getElementById('arrangement_upload');

    holidayRadios.forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.value === 'NO') {
                arrangementUpload.style.display = 'grid';
            } else {
                arrangementUpload.style.display = 'none';
            }
        });
    });

    // Initially hide nested fields
    nestedFields.style.display = 'none';
});
</script>

</body>
</html>

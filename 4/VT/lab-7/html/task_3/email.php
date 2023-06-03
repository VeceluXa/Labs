<?php
require_once 'config.php';
require_once 'PHPMailer/src/PHPMailer.php';
require_once 'PHPMailer/src/SMTP.php';
require_once 'PHPMailer/src/Exception.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

function validateFormFields($formData)
{
    $errors = [];

    // Validate username
    if (!isset($formData['username']) || empty($formData['username'])) {
        $errors[] = 'Please enter your name.';
    }

    // Validate phone number
    $pattern = '/^\+(?:[0-9] ?){6,14}[0-9]$/';
    if (!isset($formData['phone']) || empty($formData['phone'])) {
        $errors[] = 'Please enter your phone number.';
    } elseif (!preg_match($pattern, $formData['phone'])) {
        $errors[] = 'Phone number is not valid.';
    }

    // Validate email
    if (!isset($formData['email']) || empty($formData['email'])) {
        $errors[] = 'Please enter your email address.';
    } elseif (!filter_var($formData['email'], FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Please enter a valid email address.';
    }

    // Validate topic
    if (!isset($formData['topic']) || empty($formData['topic'])) {
        $errors[] = 'Please enter your topic.';
    }

    // Validate message
    if (!isset($formData['message']) || empty($formData['message'])) {
        $errors[] = 'Please enter your message.';
    }

    return $errors;
}

function sendEmailBuiltIn($formData): bool
{
    $to = $formData['email'];
    $subject = $formData['topic'];

    $emailMessage = "Username: " . $formData['username'] . "\n";
    $emailMessage .= "Phone: " . $formData['phone'] . "\n";
    $emailMessage .= "Message: " . $formData['message'] . "\n";

    $email = "freddy.0458@gmail.com";
    $headers = [
        "From" => $email,
        "Reply-To" => $email,
        "X-Mailer" => "PHP/" . phpversion(),
        "Content-type" => "text/html; charset=utf-8"
    ];

    $smtpHost = 'smtp.gmail.com';
    $smtpPort = 587;

    ini_set('SMTP', $smtpHost);
    ini_set('smtp_port', $smtpPort);
    // Create config.php with EMAIL_ADDRESS and EMAIL_PASSWORD defines
    ini_set('sendmail_from', EMAIL_ADDRESS);
    ini_set('auth_username', EMAIL_ADDRESS);
    ini_set('auth_password', EMAIL_PASSWORD);

    return mail($to, $subject, $emailMessage, $headers);
}

function sendEmailPHPMailer($formData): bool
{
    $to = $formData['email'];
    $subject = $formData['topic'];

    $emailMessage = "Username: " . $formData['username'] . "\n";
    $emailMessage .= "Phone: " . $formData['phone'] . "\n";
    $emailMessage .= "Message: " . $formData['message'] . "\n";

    // Failed to send email
    // Try PHPMailer instead
    $mail = new PHPMailer();

    // Log data in 'mail_debug.log' file in this folder
    // Create mail_debug.log if it is not created
    // Set permissions to read and write for all users
    $mail->SMTPDebug = SMTP::DEBUG_LOWLEVEL;
    $mail->Debugoutput = function ($str, $level) {
        file_put_contents(
            './mail_debug.log',
            date('Y-m-d H:i:s') . "\t" . $str . "\n",
            FILE_APPEND | LOCK_EX
        );
    };

    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = EMAIL_ADDRESS;
    $mail->Password = EMAIL_PASSWORD;
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;
    
    $mail->CharSet = "UTF-8";
    $mail->Encoding = 'base64';
    $mail->setFrom(EMAIL_ADDRESS, $formData['username']);
    $mail->addAddress($to, 'Recipient Name');
    $mail->Subject = $subject;
    $mail->Body = $emailMessage;

    return $mail->send();
}

// Usage example:
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $response = array();
    $formErrors = validateFormFields($_POST);

    if (empty($formErrors)) {
        $response['success'] = true;

        $emailResponse = sendEmailPHPMailer($_POST);
        if (!$emailResponse) {
            $response['success'] = false;
            $response['message'] = "Can't send email.";
        } else {
            $response['message'] = "Success!";
        }

    } else {
        $response['success'] = false;
        $response['message'] = "Error. ";
        foreach ($formErrors as $error) {
            $response['message'] .= $error;
        }
    }
}
header('Content-Type: application/json');
echo json_encode($response);
?>
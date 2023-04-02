<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);

include( BASE_PATH . 'smtp/PHPMailerAutoload.php');

//Check for logged in 
if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

$error = "";

function createPayment($db){

    $merchant     = $_POST['merchant'] ? trim($_POST['merchant']) : null;
    $price        = $_POST['price'] ? trim($_POST['price']) : 0;

    if(!$merchant)
    {

        return returnResponse(false, "Please select a merchant.");

    }

    if(!$price)
    {

        return returnResponse(false, "Price is requred.");

    }

    // find the merchant with the id passed
    $merchant = $db->query("SELECT * FROM merchants WHERE id = :id LIMIT 1", [
        'id'  => $merchant
    ])->find();

    if(!$merchant) {

        return returnResponse(false, "Merchant is not found or registered.");
  
    }

    // If the price enter is greater than  receivable amount of merchant 
    // return erro
    if((int) $price > $merchant['receivable'])
    {

        return returnResponse(false, "Amount doesnot match.");

    }


    try {

        //Create payment
        $created = $db->query("INSERT INTO payments(merchant_id, price, created_at) VALUES(:merchant_id, :price, :created_at)", [
            'merchant_id'    => $merchant['id'],
            'price'          => (int) $price,
            'created_at'     => date('Y-m-d H:i:s'),
        ]);

        // And descrease the receivable amount of merchant by the price
        $decreased = $db->query("UPDATE merchants SET receivable = (receivable - :amount) WHERE id = :id LIMIT 1", [
            'id'          => $merchant['id'],
            "amount"      => (int) $price,
        ]);

                // Email setup 
        $emailSubject = 'Payment Recieved.';

        $headers        = ['From' => "futsoul@no-reply.com", 'Reply-To' => $_POST['email'], 'Content-type' => 'text/html; charset=iso-8859-1'];

        $bodyParagraphs = ["Name: {$merchant['name']}", "Email: {$merchant['email']}", "Message:", "You have received a payment of Rs{$price}"];

        $body           = join(PHP_EOL, $bodyParagraphs);



        //Php mailer 
        $mail = new PHPMailer(); 
        $mail->IsSMTP(); 
        $mail->SMTPAuth = true; 
        $mail->SMTPSecure = 'tls'; 
        $mail->Host = 'sandbox.smtp.mailtrap.io';
        $mail->Port = 2525;
        $mail->IsHTML(true);
        $mail->CharSet = 'UTF-8';
        $mail->Username = MAILTRAP_USERNAME;
        $mail->Password = MAILTRAP_PASSWORD;    
        $mail->SetFrom("prabanony@gmail.com");
        $mail->Subject = $emailSubject;
        $mail->Body = $body;
        $mail->AddAddress($merchant['email']);
        $mail->SMTPOptions=array('ssl'=>array(
            'verify_peer'=>false,
            'verify_peer_name'=>false,
            'allow_self_signed'=>false
        ));

        // sende email
        $mail->Send();
        return [
            "status"  => true,
            "message" => "Payment created.",
        ];

    } catch (\Exception $e){

        return returnResponse(false, $e->getMessage());


    }


}

//if only post method
if($_SERVER['REQUEST_METHOD'] == 'POST') {

    $data = createPayment($db);

    if(!$data['status']) {

        $_SESSION['error']  = $data['message'];

        redirectTo('payment/create');


    }


    $_SESSION['success']  = $data['message'];

    redirectTo('payment/create');

}

// get the merchants which has receivable amount and profile is completed
$merchants = $db->query("SELECT * FROM merchants where receivable > 0 AND is_completed = 1")->get();

// Enocde the merchants array sinto json
$mJson = json_encode($merchants, TRUE);

// return view
require_once view("views/admin/payment/create.view.php");


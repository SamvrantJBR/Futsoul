<?php

use Core\Database;

include( BASE_PATH . 'smtp/PHPMailerAutoload.php');

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);

if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

// echo $_SESSION['id'];
// echo $_SESSION['username'];

$email    = $_POST['email'] ?? '';
$message  = "";

// if only ppost request
if($_SERVER['REQUEST_METHOD'] == 'POST') {

    $response = resetPassword($db);

    if(!$response['status']) {

        $message = $response['message'];

    } else {

        $_SESSION["success"] = "Your password has been reset.";

        header("Location: /dashboard");

        exit();

        
    }

}

require_once view("views/reset.view.php");

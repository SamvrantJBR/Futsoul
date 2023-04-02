<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);


$error    = "";
$success  = "";


if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

include( BASE_PATH . 'smtp/PHPMailerAutoload.php');

$data = [
    'name'  => $_POST['name'] ?? null,
    'email'  => $_POST['email'] ?? null,
    'phone'  => $_POST['phone'] ?? null,
    'futsal_name'  => $_POST['futsal_name'] ?? null,
    'location'  => $_POST['location'] ?? null,
    'price'  => $_POST['price'] ?? null,
    'start_time'  => $_POST['start_time'] ?? null,
    'end_time'  => $_POST['end_time'] ?? null,
    'description'  => $_POST['description'] ?? null,
];

if($_SERVER['REQUEST_METHOD'] == 'POST') {

    $response = createNewMerchantByAdmin($db);

    if(!$response['status']) {

        $error = $response['message']; 

    } else {

        $success = "Merchant created."; 
        $data = [
            'name'  =>  null,
            'email'  =>  null,
            'phone'  =>  null,
            'futsal_name'  =>  null,
            'location'  =>  null,
            'price'  =>  null,
            'note'  =>  null,
        ];

    }


}


require_once view("views/admin/merchant/create.view.php");


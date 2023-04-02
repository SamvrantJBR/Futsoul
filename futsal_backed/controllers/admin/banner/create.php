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


if($_SERVER['REQUEST_METHOD'] == 'POST') {

    $response = addBanner($db);

    if(!$response['status']) {

        $error = $response['message']; 

    } else {

        $success = "Banner created."; 

    }


}

require_once view("views/admin/banner/create.view.php");


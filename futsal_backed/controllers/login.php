<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);

if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){

    header("location: /dashboard");

    exit;

}



$errors = [

	'status'  => false,

	'message' => ''

];

$email    = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

//Check if request is post
if($_SERVER['REQUEST_METHOD'] == 'POST') {


	// login admin
	$response = loginAdmin($db);

	if(!$response['status']) {

		$errors['status']  = true;
		$errors['message'] = $response['message'];

	} else {
		      	
        // Redirect user to dashboard page if status is true
        header("location: /dashboard");

        exit();

	}

}  


require_once view("views/index.view.php");

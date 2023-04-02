<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Content-Type: application/json');
header('Access-Access-Allow-Headers: Access-Access-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

$db = new Database($config['database']);

include( BASE_PATH . 'smtp/PHPMailerAutoload.php');



if($_SERVER['REQUEST_METHOD'] != 'POST') {

	errorResponse("The method is not allowed.");

} else {

	$response = sendMerchantOTP($db);

	if(!$response['status']) {

		errorResponse($response['message']);

	} else {

		successResponse($response['message'], []);

	}



}


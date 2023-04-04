<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Content-Type: application/json');
header('Access-Access-Allow-Headers: Access-Access-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

$accessToken = getBearerToken();

$db          = new Database($config['database']);

if($_SERVER['REQUEST_METHOD'] != 'POST') {

	errorResponse("The method is not allowed.");

} else {

	$response = completeBooking($db, $accessToken);

	if(!$response['status']) {

		errorResponse($response['message']);

	} else {

		successResponse("Payment Complete", $response['data']);

	}

}


<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Content-Type: application/json');
header('Access-Access-Allow-Headers: Access-Access-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

$db = new Database($config['database']);



function isAvailable($db) {

	$accessToken = getBearerToken();

	if($_SERVER['REQUEST_METHOD'] != 'POST') {

		return returnResponse(false, "The method is not allowed.");

	} 

	if(!$accessToken) 
	{
		return returnResponse(false, "401 Unauthorized.");

	}

	$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
		'token'  => $accessToken
	])->find();

	if(!$user)
	{

		return returnResponse(false, "401 Unauthorized.");

	}

	$date = $_POST['date'];
	$time = $_POST['time'];


	if(!$date || !$time) {

		return returnResponse(false, "Please enter a date.");

	}

	$futsal  = $db->query("SELECT * FROM merchants WHERE id = :id  AND is_completed IS NOT NULL LIMIT 1", [
		'id' => $_POST['id']
	])->find();

	if(!$futsal) {

		return returnResponse(false, "The futsal was not found.");

	} 

	$sql = "SELECT * FROM offdays WHERE merchant_id = :merchant AND (start_date >= :day AND end_date <= :day2 AND start_time = :t)";
	$fields['merchant'] = $futsal['id'];
	$fields['day']      = $date;
	$fields['day2']     = $date;
	$fields['t']        = $time;

	$offdays = $db->query($sql, $fields)->find();


	return [

		'status'  => true,

		'data'    => (bool) $offdays ? true : false
	];


}


$response = isAvailable($db);

if(!$response['status']) {

	errorResponse($response['message']);

} else {

	successResponse("", $response['data']);
	

}


<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

//For ajax 
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Content-Type: application/json');
header('Access-Access-Allow-Headers: Access-Access-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

//Intantiate db to use class methods
$db = new Database($config['database']);
	
//gee the token passed on header
$accessToken = getBearerToken();

//return message if not passed
if(!$accessToken) {

	errorResponse("401 Unauthorized.");

} else {


	//get the merchant/futsal id
	$id      = $_GET['id'] ?? false;

	//check for the id
	if(!$id) {

		errorResponse("Param is missing.");

	} else {
				
		// Check the method
		if($_SERVER['REQUEST_METHOD'] != 'GET') {

			errorResponse("The method is not allowed.");

		} else {


			//Get the futsal which match the id
			$futsal  = $db
				->query("SELECT * FROM merchants WHERE id = :id  AND is_completed = 1 LIMIT 1", [
					'id' => $_GET['id']
				])
				->find();

			//If not found return message
			if(!$futsal) {

				returnResponse(false, "Futsal not available.");

			} else {

			//Get the offdays of today, tomorrow and day after tommorrow
			//This is because futsal can be booked on these days
			$offdays = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant AND start_date >= :day AND start_date <= :day2", [
				'merchant' => $futsal['id'],
				"day"      => date("Y-m-d"),
				"day2"     => date("Y-m-d")
			])->get();


			//Get all hourly time slots of today + next 2 days
			$slots = generateTimeRange($db, 
						$futsal['id'], 
						$futsal['start_time'] ?? "07:00", 
						$futsal['end_time'] ?? "21:00", 
						$offdays
					);

			// Return 
			successResponse("Fetched.", [
				'futsal'  => [
					'id'          => (int) $futsal['id'],
	                'banner'      => BASE_URL . $futsal['banner'],
	                'image'       => BASE_URL . $futsal['image'],
	                'name'        => $futsal['name'],
	                'phone'       => $futsal['phone'],
	                'email'       => $futsal['email'],
	                'is_available'  => count($offdays) > 0 ? false : true,
	                'futsal_name'  => $futsal['futsal_name'],
	                'location'  => $futsal['location'],
	                'price'     => $futsal['price'],
	                'description'  => $futsal['description'],
	                'is_available'  => false,
	                'is_completed'  =>  (bool) $futsal['is_completed'],
	                'start_time'  => $futsal['start_time'],
	                'end_time'    => $futsal['end_time'],
	                'created_at'  => $futsal['created_at'],
	                'updated_at'  => $futsal['updated_at'],
				],
				'slots'   => $slots
			]);

			

		}


		}

	}

}


<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Content-Type: application/json');
header('Access-Access-Allow-Headers: Access-Access-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

//Initialize Database Class
//- to use the functions / methods, froms the class
//- assigned a variable
$db = new Database($config['database']);


// Get the search from the query parameter
$search      = $_GET['search'] ?? false;
	
// if not sent, then return error message and status to false
if(!$search) {

	errorResponse("Search is required.");

} else {
			
	// If the method is not GET Request then return false, and error message
	if($_SERVER['REQUEST_METHOD'] != 'GET') {

		errorResponse("The method is not allowed.");

	} else {

		// If the request is a 'GET' Request
		// Then search the merchants table which match the search value 
		// Merchant is also a futsal company
		$matched  = $db
			->query("SELECT id, name, email ,phone, futsal_name, location, price, start_time, end_time, is_completed, created_at, updated_at FROM merchants WHERE is_completed IS NOT NULL AND futsal_name LIKE CONCAT( '%', :search, '%')", [
				'search'  => $_GET['search'],
			])->get();

		$modified = [];
		
		foreach($matched as $value){
			$modified[]  = [
				'id'          => (int) $value['id'],
                'banner'      => BASE_URL . $value['banner'],
                'image'       => BASE_URL . $value['image'],
                'name'        => $value['name'],
                'phone'       => $value['phone'],
                'email'       => $value['email'],
                'futsal_name'  => $value['futsal_name'],
                'location'  => $value['location'],
                'price'  => $value['price'],
                'description'  => $value['description'],
                'is_completed'  => (bool) $value['is_completed'],
                'is_available' => true,
                'receivable' => $value['receivable'],
                'start_time'  => $value['start_time'],
                'end_time'  => $value['end_time'],
                'created_at'  => $value['created_at'],
                'updated_at'  => $value['updated_at'],
			];
		}

		// Now return a message with status true and all the matched merchants
		successResponse("Fetched.", [
			"data"  => $modified
		]);


	}

}


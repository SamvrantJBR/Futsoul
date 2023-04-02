<?php

use Core\Database; // Use the Database Namespace

// Get config variable
$config  = require BASE_PATH . "/config.php";

//Set Allow Headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Content-Type: application/json');
header('Access-Access-Allow-Headers: Access-Access-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

//Instantiate db and assign to a variable $db
$db = new Database($config['database']);


//If Request is not get return error message
if($_SERVER['REQUEST_METHOD'] != 'GET') {

	errorResponse("The method is not allowed.");

} else {


	// Get all banners order by id in descending order from banners table
	$banners = $db->query("SELECT * FROM 
				banners ORDER BY id DESC")->get();

	// Create a variables to hold all banners
	$modified = [];

	// loop one by one the banners
	foreach($banners as $banner) {

		// Push tot modified array as an array
		$modified[] = [
			'id'  		  => (int) $banner['id'],
			'image'       => BASE_URL . $banner['image'],
			'created_at'  => $banner['created_at'],
			'updated_at'  => $banner['updated_at'],
		];

	}


	// Finally return the data
	successResponse("Fetched Banners.", [
		'status' => true,
		'data'   => $modified
	]);

}



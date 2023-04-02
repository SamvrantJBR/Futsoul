<?php

//Method to toggle a merchant/futsal a favourite
//This will set a merchant as favourite if not already a favourite
//And vice versa
function toggleFavouriteMerchant($db, $token) {
	
	// Check if token matched
	$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}

	//Ge the merchant_id which the user want as favourit
	$merchant = $_POST['merchant_id'] ?? null;

	if(!$merchant || !is_numeric($merchant)) {

		return returnResponse(false, "Invalid Merchant ID.");

	}

	//Get the merchant that matches the id
	//This is to ensure that the merchant with the passed id exists
	//
	$found_merchant = $db->query("SELECT * FROM merchants WHERE id = :id AND is_completed IS NOT NULL LIMIT 1", [
		
		'id'  => $merchant,

	])->find();

	if(!$found_merchant) {

		return returnResponse(false, "Merchant not found.");

	}

	///IF exits
	try {

		//Get from favourite table if the 
		//user_id and merchant_id is matched
		$isFavourite = $db->query("SELECT * FROM favourites WHERE user_id = :user AND merchant_id = :merchant LIMIT 1", [
			'user'       => $user['id'],

			'merchant'   => $found_merchant['id'] 
		])->find();

		//If exits
		//then the merchant is a favourite of the user
		if($isFavourite) {

			// Then delete the merchant a favourite 
			$db->query("DELETE FROM favourites WHERE id = :id LIMIT 1", [
				'id'       => $isFavourite['id'],
			]);

			$message = "Removed as favourite.";

		} else {

			// If not add as a favourite
			// call query method with parameters
			// First is query mysql
			// Second if the db table colums
			$db->query("INSERT INTO favourites(user_id, merchant_id, created_at) VALUES(:user, :merchant, :created)", [

				'user'       => $user['id'],

				'merchant'   => $found_merchant['id'] ,

				'created' => date("Y-m-d H:i:s")

			]);

			$message = "Add as a favourite.";

		}

		return [

			'status'  => true,

			'message' => $message,

			'data'   => [

				"isFavourite"  =>  $isFavourite ? false : true

			]

		];

	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}

///Check if the merchant is afavourite
function isMerchantAFavourite($db, $token) 
{

	// if authorixed
	$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}

	$merchant = $_POST['merchant_id'] ?? null;

		if(!$merchant || !is_numeric($merchant)) {

		return returnResponse(false, "Invalid Merchant ID.");

	}

	$found_merchant = $db->query("SELECT * FROM merchants WHERE id = :id  AND is_completed IS NOT NULL LIMIT 1", [
		
		'id'  => $merchant,

	])->find();

	if(!$found_merchant) {

		return returnResponse(false, "Merchant not found.");

	}

	$isFavourite = $db->query("SELECT * FROM favourites WHERE user_id = :user AND merchant_id = :merchant LIMIT 1", [
		'user'       => $user['id'],

		'merchant'   => $found_merchant['id'] 
	])->find();

	$message = "Merchant is a favourite.";

	if(!$isFavourite) {

		$message = "Merchant is not a favourite.";

	}

	return [

		'status'  => true,

		'message' => $message,

		'data'    => [

			"isFavourite"  =>  $isFavourite ? true : false

		]

	];


}

//Get all favourites of users with pagination
function getUserFavourites($db, $token)
{
	// if authorixed
	$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}

	$limit = 10; //Show 10 per page

	// Current pagination page number
	$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
	
	// Offset
	$paginationStart = ($page - 1) * $limit; //offset 

	try {

		$favouritesCount  = $db->query("SELECT COUNT(*) FROM favourites WHERE user_id = :user", [
			
			'user'  		=> $user['id'],

		])->total();

		//Get the favourite with all relationships
		//Join the merchants table to getthe merchant data
		$favouritesList  = $db->query("SELECT * FROM 
		(
			favourites
			INNER JOIN (SELECT id, name as merchant_name, email  as merchant_email, phone as merchant_phone, image as merchant_image, banner, futsal_name, location, price, receivable, description, is_completed, start_time, end_time, created_at as created, updated_at as updated FROM merchants) AS merchant ON favourites.merchant_id = merchant.id

		) WHERE user_id = :user ORDER BY favourites.id DESC LIMIT $paginationStart, $limit ", [
			
			'user'  		=> $user['id'],

		])->get();


		//The number of pgaes
		$count = ceil($favouritesCount / $limit);

		$modified = [];

		foreach ($favouritesList as $fav) {
			
			$modified[] = [
				'id' => (int) $fav['merchant_id'],
				'image' =>  BASE_URL . $fav['merchant_image'],
				'banner' => BASE_URL . $fav['banner'],
				'name'  => $fav['merchant_name'],
				'email' => $fav['merchant_email'],
				'futsal_name' => $fav['futsal_name'],
				'location' => $fav['location'],
				'price' => $fav['price'],
				'description' => $fav['description'],
				'is_completed' => (bool) $fav['is_completed'],
				'is_available' => true,
				'receivable' => (int) $fav['receivable'],
				'start_time' => $fav['start_time'],
				'end_time' => $fav['end_time'],
				'created_at' => $fav['created'],
				'updated_at' => $fav['updated'],
			];

		}

		return [

			'status'  => true, 

			'message' => "Favourites List",

			'data'    => [
				
				'current_page'  => (int) $page,

				'data'   => $modified,

				'total'  => (int) $favouritesCount,

				'pages'  => (int) $count,

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}



}
<?php

function getMerchantFavourites($db, $token)
{
	// if authorixed
	$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$merchant) {

		return returnResponse(false, "401 Unauthorized.");

	}

	$limit = 10;

	// Current pagination page number
	$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
	
	// Offset
	$paginationStart = ($page - 1) * $limit;

	try {

		$favouritesCount  = $db->query("SELECT COUNT(*) FROM favourites WHERE merchant_id = :merchant", [
			
			'merchant'  		=> $merchant['id'],

		])->total();

		$favouritesList  = $db->query("SELECT * FROM 
		(
			favourites
			INNER JOIN (SELECT id, name as user_name, user_email  as merchant_email, phone as user_phone, image, created_at as created FROM users) AS user ON favourites.user_id = user.id

		) WHERE merchant_id = :merchant ORDER BY favourites.id DESC LIMIT $paginationStart, $limit ", [
			
			'merchant'  		=> $merchant['id'],

		])->get();


		$count = ceil($favouritesCount / $limit);


		$modified  = [];
		
		foreach($favouritesList as $fav)
		{
			$modified[] = [
				"id" => (int) $fav['id']   ,
                "user_id" => $fav['user_id'],   
                "merchant_id" => $fav['merchant_id']   ,
                "transaction_id"  => $fav['transaction_id']  ,
                "day" => $fav['day'],
                "type" => $fav['type'] ,  
                "payment_token" => $fav['payment_token']   ,
                "start_time"  => $fav['start_time']  ,
                "end_time"  => $fav['end_time']  ,
                "price" => $fav['price'] ,
                "status" => $fav['status']   ,
                "is_cancelled_at" => $fav['is_cancelled_at']  ,
                "created_at" => $fav['created_at']     ,
                "updated_at" => $fav['updated_at']   ,
                "full_name" => $fav["full_name"],
                "email" => $fav["email"],
                "phone" => $fav["phone"],

                "user"  => [
                	"id"  => (int) $fav['user_id'],
                	"name"  => $fav['user_name'],
                	"email"  => $fav['user_email'],
                	"phone"  => $fav['user_phone'],
                	"image"  => BASE_URL . $fav['image'],
                	"created_at"  => $fav['created'],
                ]
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
<?php

//Get the user recent bookings list with pagination
function getUserRecentBookings($db, $token) {

	// if authorixed
	$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}

	$limit = 10;

	// Current pagination page number
	$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
	
	// Offset
	$paginationStart = ($page - 1) * $limit;

	try {

		$bookingCount  = $db->query("SELECT COUNT(*) FROM bookings WHERE user_id = :user", [
			
			'user'  		=> $user['id'],

		])->total();

		//Ge the booking with the merchant detials
		$bookingList  = $db->query("SELECT * FROM (
			bookings
			INNER JOIN (SELECT id, name as merchant_name, email  as merchant_email, phone as merchant_phone, image as merchant_image, banner, futsal_name, location, price, receivable, description, is_completed, start_time as start, end_time as end, created_at as created, updated_at as updated  FROM merchants) AS merchant ON bookings.merchant_id = merchant.id

		) WHERE user_id = :user ORDER BY bookings.id DESC LIMIT $paginationStart, $limit ", [
			
			'user'  		=> $user['id'],

		])->get();


		$count = ceil($bookingCount / $limit);

		$modified = [];
		foreach ($bookingList as $booking ) {
			$modified[] = [
				'id'   => (int) $booking['id'],
				"user_id" => (int) $booking["user_id"],
                "merchant_id" => (int) $booking["merchant_id"],
                "transaction_id" => $booking["transaction_id"],
                "day" => $booking["day"],
                "type" => $booking["type"],
                "payment_token" => $booking["payment_token"],
                "start_time" => $booking["start_time"],
                "end_time" => $booking["end_time"],
                "price" => $booking["price"],
                "status" => $booking["status"],
                "is_cancelled_at" => $booking["is_cancelled_at"],
                "created_at" => $booking["created_at"],
                "updated_at" => $booking["updated_at"],
                "full_name" => $user['name'],
                "email" => $user["email"],
                "phone" => $user["phone"],

                "merchant"   => [
                	'id' => (int) $booking['merchant_id'],
					'image' =>  BASE_URL . $booking['merchant_image'],
					'banner' => BASE_URL . $booking['banner'],
					'name'  => $booking['merchant_name'],
					'email' => $booking['merchant_email'],
					'futsal_name' => $booking['futsal_name'],
					'location' => $booking['location'],
					'price' => $booking['price'],
					'description' => $booking['description'],
					'is_completed' => (bool) $booking['is_completed'],
					'is_available' => true,
					'receivable' => (int) $booking['receivable'],
					'start_time' => $booking['start'],
					'end_time' => $booking['end'],
					'created_at' => $booking['created'],
					'updated_at' => $booking['updated'],
                ]
			];
		}

		return [

			'status'  => true, 

			'data'    => [
				
				'current_page'  => (int) $page,

				'data'   => $modified,

				'total'  =>  (int) $bookingCount,

				'pages'  => (int) $count,

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}

//Generate an random string of 10 characters
function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[random_int(0, $charactersLength - 1)];
    }
    return $randomString;
}


//Method to book a futsal
function bookFutsal($db, $token) {

	// Check if authorixed/ the token matched passed on Authorization header of post request
	$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();


	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}

	$valided = validateUserBookingFields();

	if(!$valided){
		return returnResponse(false, "Some field are empty");
	}

	//Getthe futsal with id
	$futsal = $db->query("SELECT * FROM merchants WHERE id = :id LIMIT 1", [
		
		'id'  => trim($_POST['merchant_id']),

	])->find();

	// Reurn message
	//  if the futsal doesnot exits 
	//  OR 
	//  if the profile of merchant/futsal is not completedx/
	if(!$futsal || !$futsal['is_completed']) {

		return returnResponse(false, "Futsal not found.");

	}


    try {

    	// A random string as token
    	$transactionID = generateRandomString();


        //Save to bookings table
        //Call query method in the Database class
        //which is in Base path / Core / Database.php
        
        $db->query("INSERT INTO bookings(user_id, merchant_id, transaction_id, day, start_time, end_time, price, created_at, status, type) VALUES(:user_id, :merchant_id, :transaction, :day, :start_time, :end_time, :price, :created_at, :status, :type)", [

			'user_id'          => $user['id'],
			'merchant_id'      => $futsal['id'],
			'transaction'      => $transactionID,
			'day'              => trim($_POST['date']),
			'start_time'       => $_POST['start_time'] ?? null,
			'end_time'         => $_POST['end_time'] ?? null,
			'price'            => $futsal['price'],
			'created_at'       => date("Y-m-d H:i:s"),
			'status'           => "pending",
			"type"             => "online"
		]);

        //The merchant has the receivable columns
        //if the user is makeing a booking
        //them the merchant must get the amount 
        //So to tell/show the merchant 
        //The receivable field in increment by the price of the futsal
		$u = $db->query("UPDATE merchants SET receivable = (receivable + :amount) WHERE id = :id LIMIT 1", [
            'id'          => $futsal['id'],
            "amount"      => $futsal['price'],
        ]);


		//Get the currently booked details
		$new = $db->query("SELECT * FROM ( bookings INNER JOIN (SELECT id, name as merchant_name, email  as merchant_email, phone as merchant_phone, image as merchant_image, banner, futsal_name, location, price, receivable, description, is_completed, start_time, end_time, created_at as created, updated_at as updated  FROM merchants) AS merchant ON bookings.merchant_id = merchant.id
		)  WHERE transaction_id = :transaction  LIMIT 1", [
			'transaction'    => $transactionID,
		])->find();

        return [

			'status' => true,

			'data'   => [

				'id'   =>  (int)$new['id'],
				"user_id" => (int) $new["user_id"],
                "merchant_id" => (int) $new["merchant_id"],
                "transaction_id" => $new["transaction_id"],
                "day" => $new["day"],
                "type" => $new["type"],
                "payment_token" => $new["payment_token"],
                "start_time" => $new["start_time"],
                "end_time" => $new["end_time"],
                "price" => $new["price"],
                "status" => $new["status"],
                "is_cancelled_at" => $new["is_cancelled_at"],
                "created_at" => $new["created_at"],
                "updated_at" => $new["updated_at"],
                "full_name" => $user["name"],
                "email" => $user["email"],
                "phone" => $user["phone"],

                "merchant"   => [
                	'id' => (int) $new['merchant_id'],
					'image' =>  BASE_URL . $new['merchant_image'],
					'banner' => BASE_URL . $new['banner'],
					'name'  => $new['merchant_name'],
					'email' => $new['merchant_email'],
					'futsal_name' => $new['futsal_name'],
					'location' => $new['location'],
					'price' => $new['price'],
					'description' => $new['description'],
					'is_completed' => (bool) $new['is_completed'],
					'is_available' => true,
					'receivable' => (int) $new['receivable'],
					'start_time' => $new['start_time'],
					'end_time' => $new['end_time'],
					'created_at' => $new['created'],
					'updated_at' => $new['updated'],
				]

			]

		];


    } catch (\Exception $e) {

		return [

			'status' => true,

			'data'   => $e->getMessage(),

		];

    }


	return [

		'status' => true,

	];


}


function validateUserBookingFields()
{
	$merchant     	= $_POST['merchant_id'];
	$date 		    = $_POST['date'];
	$start_time     = $_POST['start_time'];
	$end_time       = $_POST['end_time'];

	if(!$merchant || !$date || !$start_time || !$end_time) {

		return returnResponse(false, "Please fill all required fields.");

	}


	return [

		'status' => true,

	];



}


//FUctions to call after the payment is made
function completeBooking($db, $token)
{

	//Get the user with mathced token
	$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();


	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}

	//Get the values passed as payload
	$transaction = $_POST['transactionId'];

	$pidx        = $_POST['pidx'];
	
	$token      = $_POST["token"];

	$amount      = $_POST['amount'];


	if(!$transaction || !$pidx || !$amount || !$token) {

		return returnResponse(false, "Some Fields are empty.");

	}

	//A,mount mus be m=numeric
	if(!is_numeric($amount)) {

		return returnResponse(false, "Amount must be numeric.");
	
	}

	//Get
	$booking = $db->query("SELECT * FROM bookings WHERE transaction_id = :transaction LIMIT 1", [
		
		'transaction'  => trim($transaction),

	])->find();


	if(!$booking) {

		return returnResponse(false, "Booking not found.");

	}

	try {	

		$headers = [
            'Authorization: Key test_secret_key_e3dae072d0ee46a48e5d08b713119810', //Satish
        ];
        
        $curl_connection = curl_init("https://khalti.com/api/v2/payment/verify/");

		curl_setopt($curl_connection, CURLOPT_RETURNTRANSFER, true);

        curl_setopt($curl_connection, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl_connection, CURLINFO_HEADER_OUT, true);


        curl_setopt($curl_connection, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl_connection, CURLOPT_POST, true);
        curl_setopt($curl_connection, CURLOPT_POSTFIELDS, http_build_query([
    	    "token"              => $token,
    	    'amount'             => round($amount * 100)

        ]));

        $result = curl_exec($curl_connection);

        $status_code = curl_getinfo($curl_connection, CURLINFO_HTTP_CODE);

        curl_close($curl_connection);

        error_log("status_code === ".  $status_code);

        $response = json_decode($result, TRUE);

        error_log("response === ".  json_encode($response, TRUE));

        $status = (!$response['idx']) ? "failed" : "booked";
        

		$db->query("UPDATE bookings SET status = :status, updated_at = :updated, payment_token =:payment_token WHERE transaction_id = :transaction LIMIT 1", [

			'transaction'  => trim($transaction),
			'status'       => $status,
			'updated'      => date("Y-m-d H:i:s"),
			'payment_token' => $token

		]);

		if(!$response['idx']) {

			return returnResponse(false, "Payment failed.");

		}



		$new = $db->query("SELECT * FROM ( bookings INNER JOIN (SELECT id, name as merchant_name, email  as merchant_email, phone as merchant_phone, image as merchant_image, banner, futsal_name, location, price, receivable, description, is_completed, start_time, end_time, created_at as created, updated_at as updated  FROM merchants) AS merchant ON bookings.merchant_id = merchant.id
		) WHERE transaction_id = :transaction  LIMIT 1", [
			'transaction'    => $transaction,
		])->find();

		return [

			'status' => true,

			'data'   => [
				'id'   =>  (int) $new['id'],
				"user_id" =>  (int) $new["user_id"],
                "merchant_id" => (int) $new["merchant_id"],
                "transaction_id" => $new["transaction_id"],
                "day" => $new["day"],
                "type" => $new["type"],
                "payment_token" => $new["payment_token"],
                "start_time" => $new["start_time"],
                "end_time" => $new["end_time"],
                "price" => $new["price"],
                "status" => $new["status"],
                "is_cancelled_at" => $new["is_cancelled_at"],
                "created_at" => $new["created_at"],
                "updated_at" => $new["updated_at"],
                "full_name" => $user["name"],
                "email" => $user["email"],
                "phone" => $user["phone"],

                "merchant"   => [
                	'id' => (int) $new['merchant_id'],
					'image' =>  BASE_URL . $new['merchant_image'],
					'banner' => BASE_URL . $new['banner'],
					'name'  => $new['merchant_name'],
					'email' => $new['merchant_email'],
					'futsal_name' => $new['futsal_name'],
					'location' => $new['location'],
					'price' => $new['price'],
					'description' => $new['description'],
					'is_available' => true,
					'receivable' => (int) $new['receivable'],
					'is_completed' =>  (bool) $new['is_completed'],
					'start_time' => $new['start_time'],
					'end_time' => $new['end_time'],
					'created_at' => $new['created'],
					'updated_at' => $new['updated'],
				]
			]
		];
	

	} catch (\Exception $e) {

        error_log("error -- " .$e->getMessage());

		return [

			'status' => true,

			'data'   => $e->getMessage(),

		];

    }



}

//Cancel booking by user
function cancel($db, $token)
{	

	try {

		//Check the token of user 
		$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
			
			'token'  => $token,

		])->find();


		if(!$user) {


			return returnResponse(false, "401 Unauthorized.");

		}

		//Get the data from payload passed
		$transaction = $_POST['transactionId'];


		if(!$transaction)
		{
			return returnResponse(false, "Transaction ID is required.");

		}

		//Get the booking with the transcation which is passed as payload in post method
		//This booking mus tbe booked or pending
		$booking = $db->query("SELECT * FROM bookings WHERE transaction_id = :transaction AND (status = :status OR status = :status2) AND is_cancelled_at IS NULL LIMIT 1", [
			
			'transaction'  => $transaction,
			'status'      => "booked",
			'status2'     => "pending",

		])->find();


		if(!$booking) {

			return returnResponse(false, "Booking not found or is cancelled.");

		}

		//Now set the booking status to cancelled
		//is_cancelled_at as current time and date
		$db->query("UPDATE bookings SET status = :status, is_cancelled_at = :cancel, updated_at = :updated WHERE transaction_id = :transaction LIMIT 1", [

			'transaction'  => $transaction,
			"status" 	   => "cancelled", 
			'cancel'       => date("Y-m-d H:i:s"),
			'updated'      => date("Y-m-d H:i:s"),

		]);

		///Then
		///The merchant hs the receivable field 
		///i.e the amount the merchant gets
		///If the booking is cancelled then the amount must be minus the booking futsal price
		///SO, hear tthe amount is decreased which was added when booked
		$u = $db->query("UPDATE merchants SET receivable = (receivable - :amount) WHERE id = :id LIMIT 1", [
			'id'          => $booking['merchant_id'],
			"amount"      => $booking['price'],
		]);


		//Now get the updated booking
		$new = $db->query("SELECT * FROM ( bookings INNER JOIN (SELECT id, name as merchant_name, email  as merchant_email, phone as merchant_phone, image as merchant_image, banner, futsal_name, location, price, receivable, description, is_completed, start_time, end_time, created_at as created, updated_at as updated  FROM merchants) AS merchant ON bookings.merchant_id = merchant.id
			) WHERE transaction_id = :transaction  LIMIT 1", [
			'transaction'    => $transaction,
		])->find();


		return [

			'status' => true,

			'data'   => [
				'id'   => (int) $new['id'],
				"user_id" => (int) $new["user_id"],
	            "merchant_id" => (int) $new["merchant_id"],
	            "transaction_id" => $new["transaction_id"],
	            "day" => $new["day"],
	            "type" => $new["type"],
	            "payment_token" => $new["payment_token"],
	            "start_time" => $new["start_time"],
	            "end_time" => $new["end_time"],
	            "price" => $new["price"],
	            "status" => $new["status"],
	            "is_cancelled_at" => $new["is_cancelled_at"],
	            "created_at" => $new["created_at"],
	            "updated_at" => $new["updated_at"],
	            "full_name" => $user["name"],
                "email" => $user["email"],
                "phone" => $user["phone"],

	            "merchant"   => [
	            	'id' => (int) $new['merchant_id'],
					'image' =>  BASE_URL . $new['merchant_image'],
					'banner' => BASE_URL . $new['banner'],
					'name'  => $new['merchant_name'],
					'email' => $new['merchant_email'],
					'futsal_name' => $new['futsal_name'],
					'location' => $new['location'],
					'price' => $new['price'],
					'description' => $new['description'],
					'is_available' => true,
					'receivable' => (int) $new['receivable'],
					'is_completed' => (bool) $new['is_completed'],
					'start_time' => $new['start_time'],
					'end_time' => $new['end_time'],
					'created_at' => $new['created'],
					'updated_at' => $new['updated'],
				]
			]
		];

	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}
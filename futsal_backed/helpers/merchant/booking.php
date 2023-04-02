<?php


function createBookingByVendor($db, $token) {

	// if authorixed
	$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$merchant) {

		return returnResponse(false, "401 Unauthorized.");

	}

	$full_name = $_POST['full_name'] ?? null;
	$email = $_POST['email'] ?? null;
	$phone = $_POST['phone'] ?? null;
	$date = $_POST['date'] ?? null;
	$start_time = $_POST['start_time'] ?? null;
	$end_time = $_POST['end_time'] ?? null;
	$price = $_POST['price'] ?? null;

	if(!$full_name || !$email || !$phone || !$date || !$start_time || !$end_time || !$price)
	{
		
		return returnResponse(false, "Some fields are missing.");

	}

	if(preg_match("/^[6-9][0-9]{9}$/", $phone) !== 1) {

		return returnResponse(false, "Please enter a valid phone number.");

	}

	if(!is_numeric($price)) {
		
		return returnResponse(false, "Price must be a numeric value.");

	}

	$diff = (int) date_diff(new DateTime(date("Y-m-d")), new DateTime($date))->format("%a");


	if( $diff  > 3){

		return returnResponse(false, "Start date must not be 3 days after or before.");

	}

	try {

		//Generation a unique id for booking for future reference
    	$transactionID = generateRandomString();


    	//Insert inot bookings with the values
        $db->query("INSERT INTO bookings(merchant_id, transaction_id, day, start_time, end_time, price, created_at, status, type, full_name, email, phone) VALUES(:merchant_id, :transaction, :day, :start_time, :end_time, :price, :created_at, :status, :type, :full_name, :email, :phone)", [

			"merchant_id"      => $merchant['id'],
			'transaction'      => $transactionID,
			'day'              => trim($date),
			'start_time'       => $start_time,
			'end_time'         => $end_time,
			'price'            => trim($price),
			'status'           => "booked",
			"type"             => "offline",
			'full_name'         => $full_name,
			'email'             => $email,
			'phone'             => $phone,
			'created_at'       => date('Y-m-d, H:i:s'),
		]);


        //Get the current created booking
        //match the transactionId created above
		$new = $db->query("SELECT * FROM bookings WHERE transaction_id = :transaction  LIMIT 1", [
			'transaction'    => $transactionID,
		])->find();

		return [

			'status'  => true, 

			'data'    => [
				
				'id'   =>  (int) $new['id'],
				"user_id" => (int) 0,
                "merchant_id" => (int) $merchant['id'],
                "transaction_id" => $new["transaction_id"],
                "day" => $new["day"],
                "type" => $new["type"],
                "payment_token" => "",
                "start_time" => $new["start_time"],
                "end_time" => $new["end_time"],
                "price" => $new["price"],
                "status" => $new["status"],
                "is_cancelled_at" => $new["is_cancelled_at"],
                "created_at" => $new["created_at"],
                "updated_at" => $new["updated_at"],
                "full_name" => $new["full_name"],
                "email" => $new["email"],
                "phone" => $new["phone"],
                "merchant"   => [
                	'id' => (int) 0,
					'image' =>  "", // Null because this is not registered user
					'name'  => "",
					'email' => "",
					'phone' => "",
					'created_at' => "",
					'updated_at' => "",
				]
			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}

//Get bookings whithc is pending and booked
function getVendorActiveBookings($db, $token) {

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

		$bookingCount  = $db->query("SELECT COUNT(*) FROM bookings WHERE merchant_id = :merchant AND (status = :status OR status = :status2 )", [
			
			'merchant'  	=> $merchant['id'],
			'status'  		=> "pending",
			'status2'  		=> "booked",

		])->total();

		//INNER JOIN is used to  get the relationship data
		$bookingList  = $db->query("SELECT * FROM (
			bookings
			LEFT JOIN (SELECT id as user_id, name as user_name, email  as user_email, phone as user_phone , image, created_at as created FROM users) AS user ON bookings.user_id = user.user_id

		) WHERE merchant_id = :merchant AND (status = :status OR status = :status2) ORDER BY bookings.day, bookings.start_time DESC LIMIT $paginationStart, $limit", [
			
			'merchant'      => $merchant['id'],
			'status'  		=> "pending",
			'status2'  		=> "booked",

		])->get();


		$count = ceil($bookingCount / $limit);


		$modified = [];

		foreach ($bookingList as $booking) {
			
			$modified[] = [
				'id'          => (int) $booking['id'],
				'user_id'     => $booking['user_id'],
				'merchant_id'     => $merchant['id'],
				'transaction_id'     => $booking['transaction_id'],
				'day'     => $booking['day'],
				'type'     => $booking['type'],
				'payment_token'     => $booking['payment_token'],
				'start_time'     => $booking['start_time'],
				'end_time'     => $booking['end_time'],
				'price'     => $booking['price'],
				'status'     => $booking['status'],
				'is_cancelled_at'     => $booking['is_cancelled_at'],
				'created_at'     => $booking['created_at'],
				'updated_at'     => $booking['updated_at'],
				"full_name" => $booking["full_name"],
                "email" => $booking["email"],
                "phone" => $booking["phone"],

                "user"  => [
                	"id"  => (int) $booking['user_id'],
                	"name"  => $booking['user_name'],
                	"email"  => $booking['user_email'],
                	"phone"  => $booking['user_phone'],
                	"image"  => BASE_URL . $booking['image'],
                	"created_at"  => $booking['created'],
                ]

			];

		}


		return [

			'status'  => true, 

			'data'    => [
				
				'current_page'  => (int) $page,

				'data'   => $modified,

				'total'  => (int) $bookingCount,

				'pages'  => (int) $count,

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}


//Get bookings which is compeleted and cancelled
function getVendorPastBookings($db, $token) {

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

		$bookingCount  = $db->query("SELECT COUNT(*) FROM bookings WHERE merchant_id = :merchant AND (status = :status OR status =:status2)", [
			
			'merchant'  	=> $merchant['id'],
			'status'  		=> "completed",
			'status2'  		=> "cancelled",

		])->total();

		$bookingList  = $db->query("SELECT * FROM (
			bookings
			LEFT JOIN (SELECT id as user_id, name as user_name, email  as user_email, phone as user_phone , image, created_at as created FROM users) AS user ON bookings.user_id = user.user_id

		) WHERE merchant_id = :merchant AND (status = :status OR status = :status2) ORDER BY bookings.id DESC LIMIT $paginationStart, $limit", [
			
			'merchant'      => $merchant['id'],
			'status'  		=> "completed",
			'status2'  		=> "cancelled",

		])->get();

		


		$count = ceil($bookingCount / $limit);


		$modified = [];

		foreach ($bookingList as $booking) {
			
			$modified[] = [
				'id'          => (int) $booking['id'],
				'user_id'     => $booking['user_id'],
				'merchant_id'     => $merchant['id'],
				'transaction_id'     => $booking['transaction_id'],
				'day'     => $booking['day'],
				'type'     => $booking['type'],
				'payment_token'     => $booking['payment_token'],
				'start_time'     => $booking['start_time'],
				'end_time'     => $booking['end_time'],
				'price'     => $booking['price'],
				'status'     => $booking['status'],
				'is_cancelled_at'     => $booking['is_cancelled_at'],
				'created_at'     => $booking['created_at'],
				'updated_at'     => $booking['updated_at'],
				"full_name" => $booking["full_name"],
                "email" => $booking["email"],
                "phone" => $booking["phone"],

                "user"  => [
                	"id"    => (int) $booking['user_id'],
                	"name"  => $booking['user_name'],
                	"email"  => $booking['user_email'],
                	"phone"  => $booking['user_phone'],
                	"image"  => BASE_URL . $booking['image'],
                	"created_at"  => $booking['created'],
                ]

			];

		}
		return [

			'status'  => true, 

			'data'    => [
				
				'current_page'  => (int) $page,

				'data'   => $modified,

				'total'  => (int) $bookingCount,

				'pages'  => (int) $count,

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}

//Manually complete booking by merchant himself
function completeBookingManually($db, $token)
{

	// if authorixed
	$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$merchant) {

		return returnResponse(false, "401 Unauthorized.");

	}

	$transaction = $_POST['transactionId'];

    // dd($transaction);


	if(!$transaction)
	{
		return returnResponse(false, "Transaction ID is required.");

	}


	//Get the booking which is not cancelled
	//whic his booked or pending
	$booking = $db->query("SELECT * FROM bookings WHERE transaction_id = :transaction AND merchant_id = :merchant LIMIT 1", [
		
		'transaction'  => $transaction,
		'merchant'     => $merchant['id'],

	])->find();



	if(!$booking) {

		return returnResponse(false, "Booking not found.");

	}
    

	//Update the status of booked as completed
	$db->query("UPDATE bookings SET status= :status, updated_at = :updated WHERE transaction_id = :transaction LIMIT 1", [

		'transaction'  => trim($transaction),
		'status'       => "completed",
		'updated'      => date('Y-m-d, H:i:s'),

	]);


	//Get the update booking data
	$new = $db->query("SELECT * FROM bookings WHERE transaction_id = :transaction  LIMIT 1", [
		'transaction'    => $transaction,
	])->find();


	return [

		'status' => true,

		'data'   => [

			'booking'        => [

				'id'      		=> (int) $new['id'],
				'user_id' 		=> $new['user_id'],
				'merchant_id' 	=> $new['merchant_id'],
				'day' 			=> $new['day'],
				'start_time' 	=> $new['start_time'],
				'end_time' 		=> $new['end_time'],
				'price' 		=> $new['price'],
				'status'        => $new['status'],
				'is_cancelled_at'  => $new['is_cancelled_at'],
				'created_at'	=> $new['created_at'],
				'updated_at'	=> $new['updated_at'],
				 "full_name" => $new["full_name"],
                "email" => $new["email"],
                "phone" => $new["phone"],


			]

		]
	];




}


// Called to cancel booking by merchant
function cancelBookingByMerchant($db, $token){
    
    try {
	// if authorixed
	// Check if merchant token match in database
	$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$merchant) {

		return returnResponse(false, "401 Unauthorized.");

	}

	//Get the transaction id passed in payload 
	$transaction = $_POST['transactionId'];

	// IF not passed return with messagex/
	if(!$transaction)
	{
		return returnResponse(false, "Transaction ID is required.");

	}

	//Get the booking which is not cancelled
	//which his booked or pending
	$booking = $db->query("SELECT * FROM bookings WHERE transaction_id = :transaction AND merchant_id = :merchant LIMIT 1", [
		
		'transaction'  => $transaction,
		'merchant'     => $merchant['id'],

	])->find();



	if(!$booking) {

		return returnResponse(false, "Booking not found.");

	}


	//Update the status of booked as cancelled
	$db->query("UPDATE bookings SET status= :status, updated_at = :updated, is_cancelled_at = :is_cancelled_at WHERE transaction_id = :transaction LIMIT 1", [

		'transaction'  			=> $transaction,
		'status'       			=> "cancelled",
		'updated'      			=> date('Y-m-d, H:i:s'),
		'is_cancelled_at'       => date('Y-m-d, H:i:s'),

	]);


	//Get the update booking data
	$new = $db->query("SELECT * FROM bookings WHERE transaction_id = :transaction AND merchant_id = :merchant  LIMIT 1", [
		'transaction'    => $transaction,
		'merchant'       => $merchant['id'],
	])->find();


	return [

		'status' => true,

		'data'   => [

			'booking'        => [

				'id'      		=> (int) $new['id'],
				'user_id' 		=> $new['user_id'],
				'merchant_id' 	=> $new['merchant_id'],
				'day' 			=> $new['day'],
				'start_time' 	=> $new['start_time'],
				'end_time' 		=> $new['end_time'],
				'price' 		=> $new['price'],
				'status'        => $new['status'],
				'is_cancelled_at'  => $new['is_cancelled_at'],
				'created_at'	=> $new['created_at'],
				'updated_at'	=> $new['updated_at'],
				 "full_name"    => $new["full_name"],
                "email" => $new["email"],
                "phone" => $new["phone"],


			]

		]
	];
	
    } catch (\Exception $e) {
        return returnResponse(false, $e->getMessage());
    }


}
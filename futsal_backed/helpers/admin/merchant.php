<?php

function createNewMerchantByAdmin($db)
{


	$validated = validateFieldsForMerchant();

	if(!$validated['status']) {

		return returnResponse(false, $validated['message']);

	}

	//Check for the merchant who has the phone and email
	$email_found = $db->query("SELECT * FROM merchants WHERE email = :email OR phone = :phone  LIMIT 1", [
		'phone'    => $validated['data']['phone'],
		'email'    => $validated['data']['email'],
	])->find();


	//If already found 
	if($email_found) {

		return returnResponse(false, "The email/phone already exists.");

	}	

	// Token for login
	$token = generateToken();

	// Random password
	$pass = getRandomString(8);

	$fields = [
		'futsal_name'   => strip_tags($_POST['futsal_name']),
		'email'         => strip_tags($_POST['email']),
		'phone'         => strip_tags($_POST['phone']),
		'password'      => password_hash($pass, PASSWORD_DEFAULT),
		'created_at'    => date("Y-m-d H:i:s"),
		'token'         => $token,
		'expiry'        => getExpiryDate(),
		'location'      => ($validated['data']['location']), 
		'price'         => ($validated['data']['price']), 
		'description'          => $validated['data']['description'] ?? null,
		'start_time'    => (new DateTime($_POST['start_time']))->format("H:i:s"),
		'end_time'      => (new DateTime($_POST['start_time']))->format("H:i:s"),
		'receivable'    => 0
	];

	try {

		//Upload Profile Image
		$imageUploaded = uploadImage($_FILES['image']);

		if(!$imageUploaded['status']) {
			
			return returnResponse(false, "Profile image cannot be uploaded.");

		}

		// Add image to save to db
		$fields['image'] = $imageUploaded['data'];


		// Upload Banner Image
		$bannerUploaded = uploadImage($_FILES['banner']);

		if(!$bannerUploaded['status']) {
			
			return returnResponse(false, "Profile image cannot be uploaded.");

		}

		// Add banner to save to db
		$fields['banner']       = $bannerUploaded['data'];
		$fields['is_completed'] = 1;

		//!uery to inseert data into merchants table	
		$db->query("INSERT INTO merchants(futsal_name, email, phone, password, created_at, token, token_expiry_at, location, price, image, banner, description, start_time, end_time, is_completed, receivable) VALUES(:futsal_name, :email, :phone, :password, :created_at, :token, :expiry, :location, :price, :image, :banner, :description, :start_time , :end_time, :is_completed, :receivable)", $fields);

		 
		// Email setup 
		$emailSubject = 'Futsal Merchant Credentials.';

		$headers        = ['From' => "futsoul@no-reply.com", 'Reply-To' => $_POST['email'], 'Content-type' => 'text/html; charset=iso-8859-1'];

		$bodyParagraphs = ["Name: {$_POST['futsal_name']}", "Email: {$_POST['email']}", "Message:", "Credentials <br /> Email:{$_POST['email']} <br /> Password: {$pass}"];

		$body           = join(PHP_EOL, $bodyParagraphs);



		//Php mailer 
		$mail = new PHPMailer(); 
		$mail->IsSMTP(); 
		$mail->SMTPAuth = true; 
		$mail->SMTPSecure = 'tls'; 
		$mail->Host = 'sandbox.smtp.mailtrap.io';
		$mail->Port = 2525;
		$mail->IsHTML(true);
		$mail->CharSet = 'UTF-8';
		$mail->Username = MAILTRAP_USERNAME;
		$mail->Password = MAILTRAP_PASSWORD;	
		$mail->SetFrom("prabanony@gmail.com");
		$mail->Subject = $emailSubject;
		$mail->Body = $body;
		$mail->AddAddress($_POST['email']);
		$mail->SMTPOptions=array('ssl'=>array(
			'verify_peer'=>false,
			'verify_peer_name'=>false,
			'allow_self_signed'=>false
		));

		// sende email
		$mail->Send();


		//Get the currently registered merchant
		$new = $db->query("SELECT * FROM merchants WHERE email = :email LIMIT 1", [
			'email'  => $validated['data']['email'],
		])->find();


		return  [

			'status'  => true,

			'data'    => [

				'accessToken' => [

					'type'  => 'Bearer',

					'accessToken'  => 'Bearer '. $token

				],

				'user'  => [ 

					'id'          => $new['id'],
					'name'        => $new['name'],
					'futsal_name' => $new['futsal_name'],
					'phone'       => $new['phone'],
					'location'    => $new['location'],
					'image'       => $new['image'],
					'email'       => $new['email'],
					'price'       => $new['price'],
					'description'        => $new['description'],
					'created_at'  => $new['created_at'],

				]

			]

		];

	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}

function validateFieldsForMerchant()
{
		
	//All Fiels
	$name 			= strip_tags($_POST['name']);
	$email 			= strip_tags($_POST['email']);
	$phone 			= strip_tags($_POST['phone']);
	$futsal_name    = strip_tags($_POST['futsal_name']);
	$location 		= strip_tags($_POST['location']);
	$price 		    = strip_tags($_POST['price']);
	$start_time 		    = strip_tags($_POST['start_time']);
	$end_time 		    = strip_tags($_POST['end_time']);
	$description 		    = strip_tags($_POST['description']);

	$image      = $_FILES['image'] ?? null;
	$banner      = $_FILES['banner'] ?? null;


	//Check if passed
	if(!$name || !$email || !$phone || !$futsal_name 
		|| !$location || !$price || !$image || !$banner || !$start_time || !$end_time
		|| !$image['tmp_name'] || !$banner['tmp_name']) {

		return returnResponse(false, "Please fill all required fields.");

	}

	if(!validateEmail($email))  {

		return returnResponse(false, "Please enter a valid email.");
			
	}

	if(preg_match("/^[6-9][0-9]{9}$/", $phone) !== 1) {

		return returnResponse(false, "Please enter a valid phone number.");

	}

	//The start_time of the futsal must be in 24 hour format eg. 14:00:00
	if(preg_match('#^([01]?[0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?$#', $start_time) !== 1) {
		
		return returnResponse(false, "Please enter a valid start time in 24 hour format.");

	}

	//Same as start_time
	if(preg_match('#^([01]?[0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?$#', $end_time) !== 1) {
		
		return returnResponse(false, "Please enter a valid end time in 24 hour format.");

	}


	return [
		'status'  => true,

		'data'  => [

			'name'  => $name,
			'email'  => $email,
			'phone'  => $phone,
			'futsal_name'  => $futsal_name,
			'location'  => $location,
			'price'  => $price,
			'start_time'  => $start_time,
			'end_time'  => $end_time,
			'banner'  => $banner,

		]
	];

}


function listMerchants($db) {

	$limit = 10;

	// Current pagination page number
	$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
	
	// Offset
	$paginationStart = ($page - 1) * $limit;

	try {

		///Count all merchants
		$merchantCount  = $db->query("SELECT COUNT(*) FROM merchants")->total();

		//Get all merchant with limit
		$merchantList  = $db->query("SELECT * FROM merchants ORDER BY id DESC LIMIT $paginationStart, $limit ")
		->get();


		$count = ceil($merchantCount / $limit);

		return [

			'status'  => true, 

			'data'    => [
				
				'current_page'  => $page,

				'data'   => $merchantList,

				'total'  => $merchantCount,

				'pages'  => $count,

				'limit'  => $limit

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}

function listUsers($db) {

	$limit = 10;

	// Current pagination page number
	$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
	
	// Offset
	$paginationStart = ($page - 1) * $limit;

	try {

		$userCount  = $db->query("SELECT COUNT(*) FROM users WHERE is_admin IS NULL")->total();

		$userList  = $db->query("SELECT * FROM users WHERE is_admin IS NULL ORDER BY id DESC LIMIT $paginationStart, $limit ")
		->get();


		$count = ceil($userCount / $limit);

		return [

			'status'  => true, 

			'data'    => [
				
				'current_page'  => $page,

				'data'   => $userList,

				'total'  => $userCount,

				'pages'  => $count,

				'limit'  => $limit

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}


function listBookings($db) {

	$limit = 10;

	// Current pagination page number
	$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
	
	// Offset
	$paginationStart = ($page - 1) * $limit;

	try {

		$bookingCount  = $db->query("SELECT COUNT(*) FROM bookings")->total();


		//Get the bookings 
		//Also join the merchant and user table
		//Beacuse the booking has merchant_id and user_id colum fields
		//THis is beacuse to get the name, and other details  of merchant and user
		//
		$bookingList  = $db->query("SELECT * FROM (
			bookings 
			LEFT JOIN (SELECT id as merchant_id, name as merchant_name, email as merchant_email, futsal_name, price, location, phone as merchant_phone FROM merchants) AS merchant ON bookings.merchant_id = merchant.merchant_id 
		LEFT JOIN (SELECT id as user_id, name as user_name, email  as user_email, phone as user_phone FROM users) as user ON bookings.user_id = user.user_id 
		) ORDER BY bookings.id DESC LIMIT $paginationStart, $limit ")
		->get();

		// dd($bookingList);

		$count = ceil($bookingCount / $limit);

		return [

			'status'  => true, 

			'data'    => [
				
				'current_page'  => $page,

				'data'   => $bookingList,

				'total'  => $bookingCount,

				'pages'  => $count,

				'limit'  => $limit

			]

		];


	} catch (\Exception $e) {


		return returnResponse(false, $e->getMessage());

	}

}
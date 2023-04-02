<?php


function loginMerchant($db) {

	$validated = validateMerchantLoginFields();

	if(!$validated['status']) {

		return returnResponse($validated['status'], $validated['message']);

	}

	// find the user with email
	$email_found = $db->query("SELECT * FROM merchants WHERE email = :email LIMIT 1", [
		'email'  => $_POST['email'],
	])->find();


	if(!$email_found) {

		return returnResponse(false, "The email not found.");

	}	


	if(!password_verify(strip_tags($_POST['password']), $email_found['password'])) {

		return returnResponse(false, "Password doesnot match.");
	
	}
	
	try {
		
		$token = generateToken();

		$db->query("UPDATE merchants SET token = :token, token_expiry_at = :expiry WHERE id = :id LIMIT 1", [

			'id'  	  => $email_found['id'],
			'token'   => $token,
			'expiry'  => getExpiryDate(),

		]);
	
		return  [

			'status'  => true,

			'data'   => [

				'accessToken' => [

					'type'  => 'Bearer',

					'accessToken'  =>  $token

				],

				'user'  => [ 

					'id'          => (int) $email_found['id'],
					'name'        => $email_found['name'],
					'futsal_name' => $email_found['futsal_name'],
					'phone'       => $email_found['phone'],
					'location'    => $email_found['location'],
					'image'       => BASE_URL . $email_found['image'],
					'banner'       => BASE_URL . $email_found['banner'],
					'email'       => $email_found['email'],
					'price'       => $email_found['price'],
					'description'        => $email_found['description'],
					'is_completed'  => (bool) $email_found['is_completed'],
					'is_available' => true,
					'receivable' => (int) $email_found['receivable'],
					'start_time'  => $email_found['start_time'],
					'end_time'  => $email_found['end_time'],
					'created_at'  => $email_found['created_at'],
				]
			]

		];

	} catch (\Exception $e) {

		return returnResponse(false, "There was some error. Please try again.");

	}


	return  returnResponse(true, "Logged in.");
	

}

function validateMerchantLoginFields()
{


	$email 			= $_POST['email'];
	$password 		= $_POST['password'];

	if(!$email || !$password) {

		return returnResponse(false, "Please fill all required fields.");

	}

	if(strlen($password) < 8)  {

		return returnResponse(false, "Password must be at least 8 characters.");
			
	}

	
	if(!validateEmail($email)) {

		return returnResponse(false, "Please enter a valid email address.");

	}

	return [
			
		'status'   => true

	];

}




function registerMerchant($db) {

	$validated = validateMerchantRegisterFields();

	if(!$validated['status']) {

		return returnResponse($validated['status'], $validated['message']);

	}

	$email_found = $db->query("SELECT * FROM merchants WHERE email = :email LIMIT 1", [
		'email'  => $validated['data']['email'],
	])->find();


	if($email_found) {

		return returnResponse(false, "The email already exists.");

	}	

	try {

		$token = generateToken();

		$db->query("INSERT INTO merchants(futsal_name, email, password, created_at, token, token_expiry_at, receivable) VALUES(:name, :email, :password, :created_at, :token, :expiry, :receivable)", [

			'name'          => strip_tags($_POST['futsal_name']),
			'email'         => strip_tags($_POST['email']),
			'password'      => password_hash(strip_tags($_POST['password']), PASSWORD_DEFAULT),
			'created_at'    => date('Y-m-d, H:i:s'),
			'token'         => $token,
			'expiry'        => getExpiryDate(),
			'receivable'    => 0,
		]);


		$new = $db->query("SELECT * FROM merchants WHERE email = :email LIMIT 1", [
			'email'  => $validated['data']['email'],
		])->find();

		return  [

			'status'  => true,

			'data'    => [

				'accessToken' => [

					'type'  => 'Bearer',

					'accessToken'  =>  $token

				],

				'user'  => [ 

					'id'          => (int)  $new['id'],
					'name'        => $new['name'],
					'futsal_name' => $new['futsal_name'],
					'phone'       => $new['phone'],
					'location'    => $new['location'],
					'image'       => BASE_URL . $new['image'],
					'banner'       => BASE_URL . $new['banner'],
					'email'       => $new['email'],
					'price'       => $new['price'],
					'description'        => $new['description'],
					'is_completed'  => (bool) $new['is_completed'],
					'is_available' => true,
					'receivable' => (int) $new['receivable'],
					'start_time'  => $new['start_time'],
					'end_time'  => $new['end_time'],
					'created_at'  => $new['created_at'],
				]

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, "There was some error. Please try again.");
	
	}

}


function validateMerchantRegisterFields()
{

	$name 		= $_POST['futsal_name'];
	// $phone 		= $_POST['phone'];
	$email 			= $_POST['email'];
	$password 		= $_POST['password'];

	if(!$name  || !$email || !$password) {

		return returnResponse(false, "Please fill all required fields.");

	}

	if(strlen($name) < 1) {

		return [
			
			'status'   => false,

			'message'  => "The first name is required.",

		];


	}

	// if(preg_match("/^[6-9][0-9]{9}$/", $phone) !== 1) {

	// 	return returnResponse(false, "Please enter a valid phone number.");

	// }


	if(strlen($password) < 8) {

		return returnResponse(false, "Password must be at least 8 characters.");


	}

	if(!validateEmail($email)) {

		return returnResponse(false, "Please enter a valid email address.");

	}

	return [
			
		'status'   => true,

		'data'     => [

			'name'  => $name,

			// 'phone'   => $phone,

			'email'       => $email,

			'password'    => $password

		] 

	];

}

function logoutMerchant($db, $token) {

	// if authorixed
	$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$merchant) {

		return returnResponse(false, "401 Unauthorized.");

	}

	try {
		
		$token = generateToken();

		$db->query("UPDATE merchants SET token = :token, token_expiry_at = :expiry WHERE id = :id LIMIT 1", [

			'id'  	  => $merchant['id'],
			'token'   => null,
			'expiry'  => null,

		]);

		return [
			
			'status'   => true,

		];


	} catch (\Exception $e) {

		return returnResponse(false, "Server error.");


	}


}

function resetMerchantPassword($db, $token) {
		
	$validated = validateMerchantResetPasswordFields();

	if(!$validated['status']) {

		return returnResponse($validated['status'], $validated['message']);

	}

	// if authorixed
	$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$merchant) {

		return returnResponse(false, "401 Unauthorized.");

	}

	if(!password_verify($validated['old'], $merchant['password'])) {

		return returnResponse(false, "Password doesnot match.");
	
	}

	try {
		

		$db->query("UPDATE merchants SET password = :password WHERE id = :id LIMIT 1", [

			'id'  	     => $merchant['id'],
			'password'   => password_hash($validated['new'], PASSWORD_DEFAULT)

		]);

		return [
			
			'status'   => true,

			'data'   => [
					'id'          => (int) $merchant['id'],
					'name'        => $merchant['name'],
					'futsal_name' => $merchant['futsal_name'],
					'phone'       => $merchant['phone'],
					'location'    => $merchant['location'],
					'image'       => BASE_URL . $merchant['image'],
					'banner'       => BASE_URL . $merchant['banner'],
					'email'       => $merchant['email'],
					'price'       => $merchant['price'],
					'description'        => $merchant['description'],
					'is_completed'  => (bool) $new['is_completed'],
					'is_available' => true,
					'receivable' => (int) $new['receivable'],
					'start_time'  => $new['start_time'],
					'end_time'    => $new['end_time'],
					'created_at'  => $merchant['created_at'],
			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, "Server error.");


	}	


}

function validateMerchantResetPasswordFields()
{

	$oldPassword 		= strip_tags($_POST['old_password']);
	$newPassword 		= strip_tags($_POST['new_password']);

	if(!$oldPassword || !$newPassword) {

		return returnResponse(false, "Please fill all required fields.");

	}


	if(strlen($newPassword) < 8) {

		return returnResponse(false, "Password must be at least 8 characters.");


	}



	return [
			
		'status'   => true,

		'old'  => $oldPassword,

		'new'  => $newPassword,

	];

}

function sendMerchantOTP($db) {

	$_POST = filter_input_array(INPUT_POST);
	
	$email 			= $_POST['email'];

	if(!validateEmail($email)) {

		return returnResponse(false, "Please enter a valid email address.");

	}

	$found = $db->query("SELECT * FROM merchants WHERE email = :email LIMIT 1", [
		'email'  => trim($email),
	])->find();

	if(!$found) {

		return returnResponse(false, "The email not found.");

	}

    // $otp            = 123456;
    $otp      = random_int(100000, 999999);

    $emailSubject = 'OTP for reseting your password.';

    $headers        = ['From' => "futsoul@no-reply.com", 'Reply-To' => $found['email'], 'Content-type' => 'text/html; charset=iso-8859-1'];

    $bodyParagraphs = ["Name: Test", "Email: {$found['email']}", "Message:", "Your otp is {$otp}"];

    $body           = join(PHP_EOL, $bodyParagraphs);


    try {


		$mail = new PHPMailer(); 
		// $mail->SMTPDebug  = 3;
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
		$mail->AddAddress($found['email']);
		$mail->SMTPOptions=array('ssl'=>array(
			'verify_peer'=>false,
			'verify_peer_name'=>false,
			'allow_self_signed'=>false
		));

		if(!$mail->Send()){

			return returnResponse(false, "Server Error. Please try again later.");

		}	else{

			$db->query("UPDATE merchants SET otp = :otp WHERE email = :email LIMIT 1", [

				'otp'    => $otp,
				'email'  => $found['email'],

			]);


			return [
				
				'status'  => true,

				'message' => 'You OTP email has been sent. Please use the otp sent to reset password.'

			];

		}


    } catch(\Exception $e) {

		return returnResponse(false, $e->getMessage());

    }



}

function resetMerchantPasswordAfterVerify($db) {

	$_POST = filter_input_array(INPUT_POST);
	
	$email 			= trim($_POST['email']);
	$otp 			= trim($_POST['otp']);
	$password 		= trim($_POST['new_password']);

	if(!$otp) {

		return returnResponse(false, "OTP is required..");

	}

	if(!$email) {

		return returnResponse(false, "Email is required..");

	}

	if(!validateEmail($email)) {

		return returnResponse(false, "Please enter a valid email address.");

	}

	if(!$password) {

		return returnResponse(false, "New Password is required..");

	}

	if(strlen($password) < 8) {

		return returnResponse(false, "Password is short.");

	}





	$found = $db->query("SELECT * FROM merchants WHERE otp = :otp AND email = :email LIMIT 1", [
		'otp'    => $otp,
		'email'  => $email,
	])->find();

	if(!$found) {

		return returnResponse(false, "The otp doesnot match.");

	}

	try {
		

		$db->query("UPDATE merchants SET password = :password, otp = null WHERE email = :email LIMIT 1", [

			'email'  	 => $email,
			'password'   => password_hash($password, PASSWORD_DEFAULT)

		]);

		return [
			
			'status'   => true,

			'message' => 'Password reset. You can now login with you new password.',

			'data'  => [

					'id'          => (int) $found['id'],
					'name'        => $found['name'],
					'futsal_name' => $found['futsal_name'],
					'phone'       => $found['phone'],
					'location'    => $found['location'],
					'image'       => BASE_URL . $found['image'],
					'banner'       => BASE_URL . $found['banner'],
					'email'       => $found['email'],
					'price'       => $found['price'],
					'description'        => $found['description'],
					'is_completed'  => (bool) $found['is_completed'],
					'is_available' => true,
					'receivable' => (int) $found['receivable'],
					'start_time'  => $found['start_time'],
					'end_time'  => $found['end_time'],
					'created_at'  => $found['created_at'],
			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, "Server error.");


	}	



}
/**Update*/
function updateMerchantProfile($db, $accessToken)
{

		// if authorixed
	$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
		
		'token'  => $accessToken,

	])->find();

	if(!$merchant) 
	{
		return returnResponse(false, "401 Unauthenticated.");

	}


	$name	        = $_POST['name'] ?? null;
	$futsal_name	= $_POST['futsal_name'] ?? null;
	$phone	        = $_POST['phone'] ?? null;
	$location	    = $_POST['location'] ?? null;
	$price	        = $_POST['price'] ?? null;
	$is_available	= $_POST['is_available'] ?? null;
	$image 		    = $_FILES['image'] ?? null;
	$banner 	    = $_FILES['banner'] ?? null;
	$description    = $_POST['description'] ?? null;

	
	$fields = [
		'id'  => $merchant['id']
	];


	$sql = "UPDATE merchants SET ";

	if($name){
		$fields['name'] = trim($name);
		$sql .= " name = :name ";
	}

	if($futsal_name){
		$fields['futsal_name'] = trim($futsal_name);
		$sql .= ", futsal_name = :futsal_name ";
	}

	if($location){
		$fields['location'] = trim($location);
		$sql .= ", location = :location ";

	}

	if($phone) {

		if(preg_match("/^[6-9][0-9]{9}$/", $phone) !== 1) {

			return returnResponse(false, "Please enter a valid phone number.");

		}

		$fields['phone'] = trim($phone);
		$sql .= ", phone = :phone ";


	}

	if($price){

		if(!is_numeric($price)) {

			return returnResponse(false, "Please enter a valid price.");

		}

		$fields['price'] = trim($price);
		$sql .= ", price = :price ";

	}

	if($is_available){

		$fields['is_available'] = 1;
		$sql .= ", is_available = :is_available ";


	}


	if($image && $image['tmp_name']){

		$imageUploaded = uploadImage($_FILES['image']);

		if(!$imageUploaded['status']) {

			return returnResponse(false, $imageUploaded['message'] ??  "Profile image cannot be uploaded.");

		}

		$fields['image'] = $imageUploaded['data'];

		$sql .= ', image = :image';


	}

	if($banner && $banner['tmp_name']){

		$bannerUploaded = uploadImage($_FILES['banner']);

		if(!$bannerUploaded['status']) {
			
			return returnResponse(false, $bannerUploaded['message'] ??  "Banner image cannot be uploaded.");

		}

		$fields['banner'] = $bannerUploaded['data'];

		$sql .= ', banner = :banner';


	}

	if($description) {

		$fields['description'] = strip_tags($description);

		$sql .= ', description = :description';

	}


	try {
		

		$db->query($sql . " WHERE id = :id LIMIT 1", $fields);


		$updated = $db->query("SELECT * FROM merchants WHERE id = :id LIMIT 1", [
		
			'id'  => $merchant['id'],

		])->find();

		return [

			
			'status'   => true,

			'data'    => [

					'id'          => (int) $updated['id'],
					'name'        => $updated['name'],
					'futsal_name' => $updated['futsal_name'],
					'phone'       => $updated['phone'],
					'location'    => $updated['location'],
					'image'       => BASE_URL . $updated['image'],
					'banner'       => BASE_URL . $updated['banner'],
					'email'       => $updated['email'],
					'price'       => $updated['price'],
					'description'   => $updated['description'],
					'is_completed'  => (bool) $updated['is_completed'],
					'is_available' => true,
					'receivable' => (int) $updated['receivable'],
					'start_time'  => $updated['start_time'],
					'end_time'  => $updated['end_time'],
					'created_at'  => $updated['created_at'],
			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());


	}	


}

function completeMerchantProfile($db, $accessToken) 
{

	// if authorixed
	$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
		
		'token'  => $accessToken,

	])->find();

	if(!$merchant) 
	{
		return returnResponse(false, "401 Unauthenticated.");

	}

	$_POST = filter_input_array(INPUT_POST);
	
	$name 			= $_POST['name'] ?? null;
	$phone 			= $_POST['phone'] ?? null;
	$location 		= $_POST['location'] ?? null;
	$price 		    = $_POST['price'] ?? null;
	$image          = $_FILES['image'] ?? null;
	$banner         = $_FILES['banner'] ?? null;
	$start_time     = $_POST['start_time'] ?? null;
	$end_time   	= $_POST['end_time'] ?? null;

	$fields = [	
		'id' => $merchant['id'],
	];

	if(!$name || !$phone || !$location || !$price || !$start_time || !$end_time) {

		return returnResponse(false, "Please enter all required fields.");

	}

	if(preg_match("/^[6-9][0-9]{9}$/", $phone) !== 1) {

		return returnResponse(false, "Please enter a valid phone number.");

	}


	if(!is_numeric($price)) {

		return returnResponse(false, "Please enter a valid price.");

	}

	$fields['name']     	= trim($name);
	$fields['phone']    	= trim($phone);
	$fields['location']     = trim($location);
	$fields['price']        = trim($price);
	$fields['start_time']        = trim($start_time);
	$fields['end_time']        = trim($end_time);

	$sql = "UPDATE merchants SET name = :name, phone = :phone , location = :location, price =:price, start_time =:start_time, end_time =:end_time ";


	if($image && $image['tmp_name']){

		$imageUploaded = uploadImage($_FILES['image']);

		if(!$imageUploaded['status']) {

			return returnResponse(false, $imageUploaded['message'] ??  "Profile image cannot be uploaded.");

		}

		$fields['image'] = $imageUploaded['data'];

		$sql .= ', image = :image';


	}

	if($banner && $banner['tmp_name']) {

		$bannerUploaded = uploadImage($_FILES['banner']);

		if(!$bannerUploaded['status']) {
			
			return returnResponse(false, $bannerUploaded['message'] ?? "Banner cannot be uploaded.");

		}

		$fields['banner'] = $bannerUploaded['data'];

		$sql .= ', banner = :banner';

	}

	try {

		$db->query($sql . " , is_completed = 1 WHERE id = :id LIMIT 1", $fields);

		$found = $db->query("SELECT * FROM merchants WHERE id = :id LIMIT 1", [
		
			'id'  => $merchant['id'],

		])->find();

		return [
			
			'status'   => true,

			'data'    => [

					'id'          => (int) $found['id'],
					'name'        => $found['name'],
					'futsal_name' => $found['futsal_name'],
					'phone'       => $found['phone'],
					'location'    => $found['location'],
					'image'       => BASE_URL . $found['image'],
					'banner'      => BASE_URL . $found['banner'],
					'email'       => $found['email'],
					'price'       => $found['price'],
					'description'        => $found['description'],
					'is_completed'  => (bool) $found['is_completed'],
					'is_available' => true,
					'receivable' => (int) $found['receivable'],
					'start_time'  => $found['start_time'],
					'end_time'    => $found['end_time'],
					'created_at'  => $found['created_at'],
			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());


	}	

}

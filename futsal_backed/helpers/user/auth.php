<?php


function loginUser($db) {

	$validated = validateUserLoginFields();

	if(!$validated['status']) {

		return returnResponse($validated['status'], $validated['message']);

	}

	// find the user with email
	$email_found = $db->query("SELECT * FROM users WHERE email = :email LIMIT 1", [
		'email'     => $_POST['email'],
	])->find();


	if(!$email_found) {

		return returnResponse(false, "The email not found.");

	}	

	// dd($email_found['password']);

	if(!password_verify(strip_tags($_POST['password']), $email_found['password'])) {

		return returnResponse(false, "Password doesnot match.");
	
	}
	
	try {
		
		$token = generateToken();

		$db->query("UPDATE users SET token = :token, token_expiry_at = :expiry WHERE id = :id  LIMIT 1", [

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

					'id'  => (int) $email_found['id'],
					'name' => $email_found['name'],
					'phone' => $email_found['phone'],
					'email' => $email_found['email'],
					'image' => BASE_URL . $email_found['image'],
					'created_at' => $email_found['created_at'],

				]

			]

		];

	} catch (\Exception $e) {

		return returnResponse(false, "There was some error. Please try again.");

	}


	return  returnResponse(true, "Logged in.");
	

}

function validateUserLoginFields()
{


	$email 			= trim($_POST['email']);
	$password 		= trim($_POST['password']);

	if(!$email || !$password) {

		return returnResponse(false, "Please fill all required fields.");

	}

	if(strlen($password) < 8)  {

		return returnResponse(false, "Password must be at least 8 characters.");
			
	}

	
	if(!validateEmail($email)) {

		return returnResponse(false, "Please enter a valide email address.");

	}

	return [
			
		'status'   => true

	];

}




function registerUser($db) {

	$validated = validateUserRegisterFields();

	if(!$validated['status']) {

		return returnResponse($validated['status'], $validated['message']);

	}

	$email_found = $db->query("SELECT * FROM users WHERE email = :email OR phone = :phone  LIMIT 1", [
		'phone'    => $validated['data']['phone'],
		'email'    => $validated['data']['email'],
	])->find();


	if($email_found) {

		return returnResponse(false, "The email/phone already exists.");

	}	


	try {

		$token = generateToken();

		$db->query("INSERT INTO users(name, phone, email, password, created_at, token, token_expiry_at) VALUES(:name, :phone, :email, :password, :created_at, :token, :expiry)", [

			'name'          => strip_tags($_POST['name']),
			'phone'         => strip_tags($_POST['phone']),
			'email'         => strip_tags($_POST['email']),
			'password'      => password_hash(strip_tags($_POST['password']), PASSWORD_DEFAULT),
			'created_at'    => date("Y-m-d H:i:s"),
			'token'         => $token,
			'expiry'        => getExpiryDate(),
		]);


		$new = $db->query("SELECT * FROM users WHERE email = :email  LIMIT 1", [
			'email'    => $validated['data']['email'],
		])->find();

		return  [

			'status'  => true,

			'data'    => [

				'accessToken' => [

					'type'  => 'Bearer',

					'accessToken'  =>  $token

				],

				'user'  => [ 

					'id'   	  => (int) $new['id'],
					'name'    => $new['name'],
					'phone'   => $new['phone'],
					'email'   => $new['email'],
					'image' => BASE_URL. $new['image'],
					'created_at' => $new['created_at'],

				]
			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, "There was some error. Please try again.");
	
	}

}


function validateUserRegisterFields()
{

	$name 		    = $_POST['name'];
	$phone 		 	= $_POST['phone'];
	$email 			= $_POST['email'];
	$password 		= $_POST['password'];

	if(!$name || !$phone || !$email || !$password) {

		return returnResponse(false, "Please fill all required fields.");

	}

	if(strlen($name) < 1) {

		return [
			
			'status'   => false,

			'message'  => "The name is required.",

		];


	}


	if(preg_match("/^[6-9][0-9]{9}$/", $phone) !== 1) {

		return returnResponse(false, "Please enter a valid phone number.");

	}


	if(strlen($password) < 8) {

		return returnResponse(false, "Password must be at least 8 characters.");


	}

	if(!validateEmail($email)) {

		return returnResponse(false, "Please enter a valide email address.");

	}

	return [
			
		'status'   => true,

		'data'     => [

			'name'  => $name,

			'email'       => $email,
			'phone'       => $phone,

			'password'    => $password

		] 

	];

}

function logoutUser($db, $token) {

	// if authorixed
	$user = $db->query("SELECT * FROM users WHERE token = :token  LIMIT 1", [
		
		'token'  => $token,


	])->find();

	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}

	try {
		
		$token = generateToken();

		$db->query("UPDATE users SET token = :token, token_expiry_at = :expiry WHERE id = :id AND is_admin = :is_admin LIMIT 1", [

			'id'  	  => $user['id'],
			'token'   => null,
			'expiry'  => null,
			'is_admin'  => false

		]);

		return [
			
			'status'   => true,

		];


	} catch (\Exception $e) {

		return returnResponse(false, "Server error.");


	}


}


/** Reset Password */
function resetUserPassword($db, $token) {
		
	$validated = validateUserResetPasswordFields();

	if(!$validated['status']) {

		return returnResponse($validated['status'], $validated['message']);

	}

	// if authorixed
	$user = $db->query("SELECT * FROM users WHERE token = :token LIMIT 1", [
		
		'token'  => $token,

	])->find();

	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}

	if(!password_verify($validated['old'], $user['password'])) {

		return returnResponse(false, "Password doesnot match.");
	
	}

	try {
		

		$db->query("UPDATE users SET password = :password WHERE id = :id LIMIT 1", [

			'id'  	     => $user['id'],
			'password'   => password_hash($validated['new'], PASSWORD_DEFAULT)

		]);

		return [
			
			'status'   => true,

			'data'  => [

				'id'   	  => (int) $user['id'],
				'name'    => $user['name'],
				'phone'   => $user['phone'],
				'email'   => $user['email'],
				'image'   => BASE_URL . $user['image'],
				'created_at' => $user['created_at'],

			]
		];


	} catch (\Exception $e) {

		return returnResponse(false, "Server error.");


	}	


}

function validateUserResetPasswordFields()
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

function sendUserOTP($db) {

	$_POST = filter_input_array(INPUT_POST);
	
	$email 			= $_POST['email'];

	if(!validateEmail($email)) {

		return returnResponse(false, "Please enter a valid email address.");

	}

	$found = $db->query("SELECT * FROM users WHERE email = :email LIMIT 1", [
		'email'  => trim($email),
	])->find();

	if(!$found) {

		return returnResponse(false, "The email not found.");

	}

    $otp            = random_int(100000, 999999);
    // $otp            = 123456;

    $emailSubject   = 'OTP for reseting your password.';

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
		$mail->Password = 'MAILTRAP_PASSWORD';	
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

			$db->query("UPDATE users SET otp = :otp WHERE email = :email LIMIT 1", [

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

function resetUserPasswordAfterVerify($db) {

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





	$found = $db->query("SELECT * FROM users WHERE otp = :otp AND email = :email LIMIT 1", [
		'otp'    => $otp,
		'email'  => $email,
	])->find();

	if(!$found) {

		return returnResponse(false, "The otp or email doesnot match.");

	}

	try {
		

		$db->query("UPDATE users SET password = :password, otp = null WHERE email = :email LIMIT 1", [

			'email'  	 => $email,
			'password'   => password_hash($password, PASSWORD_DEFAULT)

		]);


		return [
			
			'status'   => true,

			'message' => 'Password reset. You can now login with you new password.',

			'data'  => [

				'id'   	  => (int) $found['id'],
				'name'    => $found['name'],
				'phone'   => $found['phone'],
				'email'   => $found['email'],
				'image'   => BASE_URL . $found['image'],
				'created_at' => $found['created_at'],

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, "Server error.");


	}	



}


/** Update */
function updateUserProfile($db, $accessToken) 
{

	// if authorixed
	// Check if token exits
	$user = $db->query("SELECT * FROM users WHERE token = :token  LIMIT 1", [
		
		'token'  => $accessToken,


	])->find();

	if(!$user) {

		return returnResponse(false, "401 Unauthorized.");

	}


	// Filter inputs
	$_POST = filter_input_array(INPUT_POST);
	
	//All payloads
	$name 			= trim($_POST['name']);
	$phone 			= trim($_POST['phone']);
	$image 		    = $_FILES['image'] ?? '';

	$fields = [
		'id'  	 => $user['id']
	];

	//update query
	$sql = "UPDATE users SET";

	// if name passed then add to sql to update name
	if($name) 
	{
		$fields['name'] = $name;

		$sql .= ' name = :name';

	}

	// Just like name
	if($phone) 
	{

		if(preg_match("/^[6-9][0-9]{9}$/", $phone) !== 1) {

			return returnResponse(false, "Please enter a valid phone number.");

		}

		$fields['phone'] = $phone;

		$sql .= ', phone = :phone';


	}

	if($image) 
	{
		// upload image 
		$imageUploaded = uploadImage($_FILES['image']);

		if(!$imageUploaded['status']) {
			
			return returnResponse(false, "Profile image cannot be uploaded.");

		}

		$fields['image'] = $imageUploaded['data'];

		// Concat or add to the query
		$sql .= ', image = :image';


	}


	try {

		// Run the query
		$db->query($sql . " WHERE id = :id LIMIT 1", $fields);

		// Now get the updated row
		$found = $db->query("SELECT * FROM users WHERE id = :id LIMIT 1", [
			'id'  => $user['id'],
		])->find();

		return [
			
			'status'   => true,

			'message' => 'Profile updated',

			'data'  => [

				'id'   	  => (int) $found['id'],
				'name'    => $found['name'],
				'phone'   => $found['phone'],
				'email'   =>  $found['email'],
				'image'   => BASE_URL . $found['image'],
				'created_at' => $found['created_at'],

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, "Server error.");


	}	

	
}




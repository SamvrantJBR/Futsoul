<?php

function loginAdmin($db) {

    $_POST = filter_input_array(INPUT_POST);
	
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

	try {
		/// Get the admin with the email
		$found = $db->query("SELECT * FROM users WHERE email = :email AND is_admin = 1 LIMIT 1", [
			'email'  => trim($email),
		])->find();

		if(!$found) {

			return returnResponse(false, "The credential not match.");

		}

		//Verify the the passed password with the database password
		if(!password_verify(trim($password), $found['password'])) {

			return returnResponse(false, "Password doesnot match.");
		
		}
	       
	    // Store data in session variables
	    // This is used to show the user is logged in
	    $_SESSION["loggedin"] = true;
	    $_SESSION["id"]       = $found['id'];
	    $_SESSION["username"] = $found['email'];                            
        $_SESSION["success"] = "You are logged in.";

		return [
			'status'  => true,
			'message' => 'Logged in'
		];
	
	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());


	}

}

function resetPassword($db){

	$_POST = filter_input_array(INPUT_POST);
	
	$old 			= $_POST['old'];
	$new 		    = $_POST['new'];

	if(!$old || !$new) {

		return returnResponse(false, "Please fill all required fields.");

	}

	if(strlen($new) < 8)  {

		return returnResponse(false, "Password must be at least 8 characters.");
			
	}

	try {

		//Find the admin
		$found = $db->query("SELECT * FROM users WHERE email = :email AND is_admin = 1 LIMIT 1", [
			'email'  => trim($_SESSION['username']),
		])->find();

		if(!$found) {

			return returnResponse(false, "The credential not match.");

		}

		//Verify password
		if(!password_verify(trim($old), $found['password'])) {

			return returnResponse(false, "Password doesnot match.");
		
		}
	        
		// Save new pass
		$db->query("UPDATE users SET password = :password WHERE email = :email AND is_admin = 1 LIMIT 1", [

			'password' => password_hash(strip_tags($new), PASSWORD_DEFAULT),

			'email'  => trim($_SESSION['username']),

		]);

		return [
			'status'  => true,
			'message' => 'Reset'
		];
	
	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());


	}



}


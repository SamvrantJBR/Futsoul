<?php

//A method to create off days for merchant
function createMerchantOffDays($db, $token)
{
	
	try {

		// Get the merchant where access token is token
		$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
			
			'token'  => $token,

		])->find();

		//if the token doesnot match return 401 unauthorized message
		if(!$merchant) {

			return returnResponse(false, "401 Unauthorized.");

		}

		//Payloads sent by merchant
		$start_date = $_POST['start_date'] ?? null;
		$end_date   = $_POST['end_date'] ?? null;
		$start_time = $_POST['start_time'] ?? null;
		$end_time   = $_POST['end_time'] ?? null;


		if(!$start_date) {
			
			return returnResponse(false, "Please add start date.");

		}

		///Get the difference in date between today and start date 
		$diff = (int) date_diff(new DateTime(date("Y-m-d")), new DateTime($start_date))->format("%a");

		//if the differnece is less than 3 
		//or 
		//if the date is not 3 days after
		//return message 
		if( $diff < 3){

			return returnResponse(false, "Start date must be 3 days from now.");

		}

		//Mysql Query to insert data
		$columns = "INSERT INTO offdays(merchant_id, start_date";
		$values  = ") VALUES(:merchant_id, :start_date";

		//Column Fields
		$fields = [

			"merchant_id"  => (int) $merchant['id'],
			"start_date"   => $start_date,

		];

		//on the specific  day on specific time slot
		//If the start_date, end_date , start_time & end_time all are passed
		if($start_date && $end_date && $start_time && $end_time) {

			$hasAlready = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant_id AND start_date = :day AND end_date >= :day2 AND start_time <= :start_time AND end_time >= :end_time", [
	            "merchant_id" => $merchant['id'],
	            "day"         => $start_date,
	            "day2"        => $start_date,
	            "start_time"  => $start_time,
	            "end_time"    => $end_time,
	        ])->get();

	        if($hasAlready) 
			{
				return returnResponse(false, "The Date and Time has already been marked as off day.");
			}

			//If passed
			//Columsn
			$columns .= ", start_time, end_date, end_time, created_at";
			$values .= ", :start_time, :end_date, :end_time, :created_at";

			//Other Fields
			$fields['end_date']  = $end_date;
			$fields['start_time']  = $start_time;
			$fields['end_time']    = $end_time;
			$fields["created_at"]  = date("Y-m-d H:i:s") ;

			//Close the query
			$values .= ")";

			


			//call query methds in the Database Class, with query and parameters
			$db->query($columns . $values, $fields);


		}

		//on the specific  day on specific time slot
		//If the start_date, start_time & end_time all are passed
		if($start_date && $start_time && $end_time) {

			// get the offdays if in the passed day
			// Between the passed time 
			$time = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant_id AND start_date = :day AND TIME(`start_time`) BETWEEN :start_time AND :end_time", [
				"merchant_id" => $merchant['id'],
				"day"         => $start_date,
				"start_time"  => $start_time,
				"end_time"    => $end_time,
			])->get();

			//If has the time set already
			//sent message sayin gmarked day
			if($time) 
			{
				return returnResponse(false, "The Date and Time has already been marked as off day.");
			}

			//If passed
			//Columsn
			$columns .= ", start_time, end_time, created_at";
			$values .= ", :start_time, :end_time, :created_at";

			//Other Fields
			$fields['start_time']  = $start_time;
			$fields['end_time']    = $end_time;
			$fields["created_at"]  = date("Y-m-d H:i:s") ;

			//Close the query
			$values .= ")";

			//call query methds in the Database Class, with query and parameters
			$db->query($columns . $values, $fields);


		} 



		// If only start_date is passed
		if($start_date && $end_date && !$start_time && !$end_time) {

			//Check if the merchant has set the whole day as offday
			$time = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant_id AND start_date = :day", [
				"merchant_id" => $merchant['id'],
				"day"         => $start_date,
			])->get();

			//iF has set already
			//return message saying already a off day
			if($time) 
			{
				return returnResponse(false, "The Date has already been marked as off day.");
			}


			$columns .= ", end_date, created_at";
			$values  .= ",:end_date, :created_at";

			$fields["end_date"]  = $end_date;
			$fields["created_at"]  = date("Y-m-d H:i:s");

			$values .= ")";

			//Call query method in datebase class with columns, query
			$db->query($columns . $values, $fields);


		} 

			//Get the inserted data
			$new = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant_id AND start_date = :day AND LAST_INSERT_ID()  LIMIT 1", [
				"merchant_id"  => $merchant['id'],
				"day"         => $start_date,
			])->find();

		// Finally return the data - inserted data
		return [

			'status'  => true, 

			'message' => "Off days created.",

			'data'    => [

				"id"    => (int) $new['id'],
				"merchant_id"  => (int) $new['merchant_id'],
				"start_date"  => $new['start_date'],
				"end_date"    => $new['end_date'],
				"start_time"  => $new['start_time'],
				"end_time"    => $new['end_time'],

			]

		];


	} catch (\Exception $e) {

		//If any errro return error message
		//
		return returnResponse(false, $e->getMessage());

	}
}

//List all offdays of the merchants
function listMerchantOffDays($db, $token)
{
	try {

		$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
			
			'token'  => $token,

		])->find();

		if(!$merchant) {

			return returnResponse(false, "401 Unauthorized.");

		}

		//The number of items to show on current page
		$limit = 10;

		// Current pagination page number
		$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
		
		// Offset
		$paginationStart = ($page - 1) * $limit;

		//Count all offdays of current logged in merchant
		$offdaysCount  = $db->query("SELECT COUNT(*) FROM offdays WHERE merchant_id = :merchant", [
			
			'merchant'  		=> $merchant['id'],

		])->total();

		//Get only the offset days
		$offdaysList  = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant ORDER BY id DESC LIMIT $paginationStart, $limit ", [
			
			'merchant'  		=> $merchant['id'],

		])->get();


		//gets how many pages can be there 
		$count = ceil($offdaysCount / $limit);


		$modified  = [];
		//create new array
		foreach($offdaysList as $offday)
		{
			$modified[] = [
				"id" => (int) $offday['id']   ,
                "merchant_id" => $offday['merchant_id'],   
                "start_date" => $offday['start_date'] ,  
                "end_date" => $offday['end_date']   ,
                "start_time"  => $offday['start_time']  ,
                "end_time"  => $offday['end_time']  ,
                "created_at" => $offday['created_at']     ,
                "updated_at" => $offday['updated_at']   ,

			];
		}

		return [

			'status'  => true, 

			'message' => "Offdays List",

			'data'    => [
				
				'current_page'  => (int) $page,

				'data'   => $modified,

				'total'  => (int) $offdaysCount,

				'pages'  => (int) $count,

			]

		];

	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}
}

//delte merchant offday
function deleteMerchantOffDays($db, $token) {
	
	try {

		//iF not passed the id of the offday
		if(!$_POST['id']){
			
			return returnResponse(false, "Id is required.");

		}

		// Get the merchant which has the token that is passed in header
		$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
			
			'token'  => $token,

		])->find();

		if(!$merchant) {

			return returnResponse(false, "401 Unauthorized.");

		}

		//Get the offday row of the matched merchant & offday id
		$found  = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant AND id = :id ", [
			
			'merchant' => $merchant['id'],
			'id'  		=> trim($_POST['id']),

		])->get();

		if(!$found) {

			return returnResponse(false, "Record not found.");

		}

		//Query to delete offday
		$deleted  = $db->query("DELETE FROM offdays WHERE merchant_id = :merchant AND id = :id ", [
			
			'merchant' => $merchant['id'],
			'id'  		=> $found['id'],

		])->get();

		if(!$deleted) {

			return returnResponse(false, "Record couldnot be deleted at the moment.");

		}

		return [
			"status" => true,
			"message" => "Record deleted."
		];
	
	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}
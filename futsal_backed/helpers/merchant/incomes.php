<?php

///Method to ge merchant incomes
function getMerchantIncomes($db, $token)
{
	
	try {

		// Check if authorixed / if token passed on authorization is matched 
		$merchant = $db->query("SELECT * FROM merchants WHERE token = :token LIMIT 1", [
			
			'token'  => $token,

		])->find();

		if(!$merchant) {

			return returnResponse(false, "401 Unauthorized.");

		}

		//Get the bookings which is completed, booked and made online 
		// WITHIN last 30 days 
		$online  = $db->query("SELECT COALESCE(SUM(price), 0) online FROM bookings WHERE merchant_id = :merchant AND (status = :status OR status = :status2) AND type = :type AND created_at >= :days", [
			
			'merchant'   => $merchant['id'],
			'status'  	 => "completed",
			'status2'  	 => "booked",
			'type'  	 => "online",
			"days"       => date('Y-m-d', strtotime(date("Y-m-d"). ' - 30 days'))

		])->get();

		//Get the bookings which is completed, booked and made offline(created by merchant him/her self) 
		// WITHIN last 30 days 
		$offline  = $db->query("SELECT COALESCE(SUM(price), 0) offline FROM bookings WHERE merchant_id = :merchant AND (status = :status OR status = :status2) AND type = :type AND created_at >= :days", [
			
			'merchant'   => $merchant['id'],
			'status'  	 => "completed",
			'status2'  	 => "booked",
			'type'  	 => "offline",
			"days"       => date('Y-m-d', strtotime(date("Y-m-d"). ' - 30 days'))

		])->get();

		return [

			'status'  => true, 

			'message' => "Income fetched",

			'data'    => [

				"online"  => (int) $online[0]['online'],

				"offline" => (int) $offline[0]['offline']
				
			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}
}
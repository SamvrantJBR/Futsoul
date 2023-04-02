<?php

use Core\Database;

$heading = "Note";

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

	$deleted    = $db->query("DELETE FROM merchants WHERE id = :id", [
					'id' => $_POST['_id']
				]);

	if($deleted) {

		redirectTo("merchant/list");

	}

	$message['status']  = false;

} 

$id      = $_GET['id'];

if(!$id) {

	abort404();
}

$query   = "SELECT * FROM merchants WHERE id = :id LIMIT 1";

$merchant    = $db
			->query($query, [
				'id' => $id
			])
			->findOrfail();

$data['merchant'] = $merchant;

$limit = 8;

// Current pagination page number
$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;

// Offset
$paginationStart = ($page - 1) * $limit;

$bookingCount  = $db->query("SELECT COUNT(*) FROM bookings WHERE merchant_id = :merchant", [
	'merchant' => $id
])->total();

$data['total_booked']  = $db->query("SELECT COALESCE(SUM(price), 0) income FROM bookings WHERE merchant_id = :merchant AND status = :status ", [
			
			'merchant'   => $id,
			'status'  	 => "booked",

		])->get();


$data['total_cancel']  = $db->query("SELECT COALESCE(SUM(price), 0) income FROM bookings WHERE merchant_id = :merchant AND status = :status ", [
			
			'merchant'   => $id,
			'status'  	 => "cancelled",

		])->get();

$data['total_completed']  = $db->query("SELECT COALESCE(SUM(price), 0) income FROM bookings WHERE merchant_id = :merchant AND status = :status ", [
			
			'merchant'   => $id,
			'status'  	 => "completed",

		])->get();

// dd($data['total_earned'][0]['income']);

$bookings = $db->query("SELECT * FROM (
			bookings
			LEFT JOIN (SELECT id as user_id, name as user_name, email  as user_email, phone as user_phone FROM users) as user ON bookings.user_id = user.user_id

		) WHERE 
			merchant_id = :merchant
		ORDER BY bookings.id 
		DESC
		LIMIT $paginationStart, $limit", [
				'merchant' => $id
			])->get();


$count = ceil($bookingCount / $limit);

$data['bookings'] = $bookings; 			
$data['pages'] = $count; 			
$data['total'] = $bookingCount; 			
$data['current_page'] = $page; 			
$data['limit'] = $limit; 			

// dd($data['merchant']);
require_once view("views/admin/merchant/show.view.php");

<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);


if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

$data = null;

if($_SERVER['REQUEST_METHOD'] != 'GET') {

    abort(404);

} 

if(!$_GET['id'])

    redirectTo("user/list");


$id = trim($_GET['id']);

// Get the user 
$found    = $db->query("SELECT * FROM users WHERE id = :id AND is_admin IS NULL LIMIT 1", [
                'id' => $id
            ])->findOrfail();

if(!$found)
{
    
    abort404();

} 

$data     = $found;



$limit = 10;

// Current pagination page number
$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;

// Offset
$paginationStart = ($page - 1) * $limit;

$bookingCount  = $db->query("SELECT COUNT(*) FROM bookings WHERE user_id = :user", [
    'user' => $id
])->total();

$bookings = $db->query("SELECT * FROM (
            bookings
            INNER JOIN (SELECT id as merchant_id, name as merchant_name, email  as merchant_email, phone as merchant_phone FROM merchants) as merchant ON bookings.merchant_id = merchant.merchant_id

        ) WHERE 
            user_id = :user
        ORDER BY bookings.id 
        DESC
        LIMIT $paginationStart, $limit", [
                'user' => $id
            ])->get();

$count = ceil($bookingCount / $limit);

$data['bookings'] = $bookings;          
$data['pages'] = $count;            
$data['total']   = $bookingCount;             
$data['current_page'] = $page;          
$data['limit'] = $limit;    


require_once view("views/admin/user/show.view.php");

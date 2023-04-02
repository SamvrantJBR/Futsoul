<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);


if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

$data = null;

if($_SERVER['REQUEST_METHOD'] != 'POST') {

    abort(404);

} 



if(!$_POST['_id'])

    redirectTo("merchant/list");

$id = trim($_POST['_id']);

$found = $db->query("SELECT * FROM bookings WHERE 
            id = :id LIMIT 1", [
                'id' => $id
            ])->find();

if(!$found)
{
    
    abort404();

} 

$deleted = $db->query("DELETE FROM bookings WHERE 
            id = :id LIMIT 1", [
                'id' => $id
            ]);


if($deleted)
{
    
    $_SESSION['success'] = "Booking Deleted.";

    redirectTo("booking/list");

}  

$_SESSION['error'] = "Booking could not be deleted at the moment.";

redirectTo("booking/list");

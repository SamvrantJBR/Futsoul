<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);

//Check for id and username 
//if not found then , the user is not logged in
if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

//Call the listBookings function 
//- The function is in helpers/admin/booking
$response = listBookings($db);

$data  = $response['data'];

// Show the view
require_once view("views/admin/booking-list.view.php");


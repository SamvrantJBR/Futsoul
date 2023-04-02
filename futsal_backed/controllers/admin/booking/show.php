<?php

use Core\Database;

// Ge the config to pass on database class
$config  = require BASE_PATH . "/config.php";

//INstantiate the Database class
$db      = new Database($config['database']);


//Check for logged in user id and username
if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

//Set data as ull
$data = null;

//Abort if request method is not get
if($_SERVER['REQUEST_METHOD'] != 'GET') {


    abort(404);

} 



//If id is not passed in query redirect to user/list
if(!$_GET['id']){

    redirectTo("user/list");

}


//Trim the id
$id = trim($_GET['id']);

//Call the bookings table where id matched the passed it
//Also join the bookings table with merchants and user tables
// - becayse booking has relationship with merchant and user table
$found = $db->query("SELECT * FROM (
            bookings
            LEFT JOIN (SELECT id as merchant_id, name as merchant_name, email  as merchant_email, phone as merchant_phone FROM merchants) as merchant ON bookings.merchant_id = merchant.merchant_id
            LEFT JOIN (SELECT id as user_id, name as user_name, email  as user_email, phone as user_phone FROM users) as user ON bookings.user_id = user.user_id

        ) WHERE 
            id = :id LIMIT 1", [
                'id' => $id
            ])->find(); //Chain find method of Database class 


// Return if not found

if(!$found)
{
    
    abort404();

} 

// Else assign the found
$data     = $found;



// Finally require the view
require_once view("views/admin/booking/show.view.php");

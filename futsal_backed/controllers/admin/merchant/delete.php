<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

//Make a Database Object
$db      = new Database($config['database']);

//Check to see if logged in or not using session
if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

$data = null;

//If request method is not post, then, abort404
if($_SERVER['REQUEST_METHOD'] != 'POST') {

    // A function which redirect to 404 page
    // This function in Core/Fuctions.php with other helpers functions
    abort(404);

} 



// Check for _id passed as form data
if(!$_POST['_id'])

    redirectTo("merchant/list");

//Trim the id
$id = trim($_POST['_id']);

// get from merchant where id matches the passed id
$found = $db->query("SELECT * FROM merchants WHERE 
            id = :id LIMIT 1", [
                'id' => $id
            ])->find();

if(!$found)
{
    
    abort404();

} 

//Query to delete the merchant
$deleted = $db->query("DELETE FROM merchants WHERE 
            id = :id LIMIT 1", [
                'id' => $id
            ]);


if($deleted)
{
    
    $_SESSION['success'] = "Merchant Deleted.";

    redirectTo("merchant/list");

}  

// If for reason failed, set error message in session which will be not to be flushed 
$_SESSION['error'] = "Merchant cannot be deleted at the moment.";

// Call function that redirects to merchant/list page
redirectTo("merchant/list");

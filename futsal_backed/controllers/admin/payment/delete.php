<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);


if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

// if not post request redirect
if($_SERVER['REQUEST_METHOD'] != 'POST') {
    
    abort404();

}


$id        = trim($_POST['_id']);

// Check for the payment in the database
$payment = $db->query("SELECT * FROM 
    payments WHERE id = :id LIMIT 1", [
    'id'  => $id,
])->findOrfail();


// if foound then delete it
$deleted = $db->query("DELETE FROM payments WHERE id = :id LIMIT 1", [
    'id'  => $payment['id'],
]);

if(!$deleted) {

    abort404();

}

// and set message
$_SESSION['success']  = "Payment Deleted.";

// And redirect
redirectTo("payment/list");




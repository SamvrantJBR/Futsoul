<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);

if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}


// Get the count of all tables
$bannerCount = $db->query("SELECT COUNT(*) FROM banners")->total();
$paymentCount = $db->query("SELECT COUNT(*) FROM payments")->total();
$merchantCount = $db->query("SELECT COUNT(*) FROM merchants")->total();
$bookingCount  = $db->query("SELECT COUNT(*) FROM bookings")->total();
$userCount    = $db->query("SELECT COUNT(*) FROM users where is_admin IS NULL")->total();


require_once view("views/admin/dashboard.view.php");


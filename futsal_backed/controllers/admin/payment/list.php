<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);


if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}


function listPayments($db){

    $limit = 10;

    // Current pagination page number
    $page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;

    // Offset
    $paginationStart = ($page - 1) * $limit;

    // Count all payments
    $paymentsCount  = $db->query("SELECT COUNT(*) FROM payments")->total();

    // Get payments with limit
    $payments = $db->query("SELECT * FROM (payments 
        LEFT JOIN (SELECT id as merchant_id, email as merchant_email, phone as merchant_phone FROM merchants ) AS merchant ON payments.merchant_id = merchant.merchant_id
    ) ORDER BY payments.id DESC LIMIT $paginationStart, $limit")->get();

    $count = ceil($paymentsCount / $limit);

    $data['data']    = $payments;          
    $data['pages']   =  $count;            
    $data['total']   =  $paymentsCount;             
    $data['current_page'] =  $page;          
    $data['limit']        =  $limit; 

    return $data;

}

$data = listPayments($db);

require_once view("views/admin/payment/list.view.php");


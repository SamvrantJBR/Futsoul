<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);


if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}


$response = listMerchants($db);

$data  = $response['data'];

require_once view("views/admin/merchant/list.view.php");


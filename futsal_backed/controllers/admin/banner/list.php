<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);


if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}


$response = listBanners($db);

$data  = $response['data'];

// dd($data['banner']);

require_once view("views/admin/banner/list.view.php");


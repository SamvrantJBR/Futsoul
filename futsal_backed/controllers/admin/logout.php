<?php

use Core\Database;

include( BASE_PATH . 'smtp/PHPMailerAutoload.php');

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);

if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}

if($_SERVER['REQUEST_METHOD'] != 'POST') {

    header("Location: /404");

    exit();

}


session_start();

// Unset all of the session variables.
$_SESSION = array();

// If it's desired to kill the session, also delete the session cookie.
// Note: This will destroy the session, and not just the session data!
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Finally, destroy the session.
session_destroy();

header("Location: /");

exit();


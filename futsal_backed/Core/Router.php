<?php

$routes = require_once  BASE_PATH  . 'routes.php';

// spl_autoload_register(function ($class) {
//     require __DIR__ . "/src/$class.php";
// });

// set_error_handler("ErrorHandler::handleEr
// ror");
// set_exception_handler("ErrorHandler::handleException");

// header("Content-type: application/json; charset=UTF-8");
// $_SERVER["REQUEST_METHOD"]
// json_decode(file_get_contents("php://input"), true); // true for associate array

$uri = parse_url($_SERVER['REQUEST_URI']);

routeToController($uri, $routes);

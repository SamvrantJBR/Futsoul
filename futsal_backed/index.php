<?php

declare(strict_types=1);

//Start to use session in 
//Session is used to store data
//Eg. current logged in user
session_start();


const BASE_PATH = __DIR__. "/";

const BASE_URL  = "http://192.168.1.67:8000/";

const MAILTRAP_USERNAME = "47cc32f04b4655";
const MAILTRAP_PASSWORD = "5fb8d07e8b8fee";

require_once BASE_PATH . "Core/Functions.php";

//This helps to know what function is called 
//And registers it
//Here , we are requiring the classes to be used
spl_autoload_register(function($class) {

	require_once BASE_PATH .str_replace("\\", DIRECTORY_SEPARATOR, $class) . ".php";

});

//Incude the Ruuter 
require_once BASE_PATH . "Core/Router.php";




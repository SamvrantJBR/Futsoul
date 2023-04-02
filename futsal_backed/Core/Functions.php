<?php

function dd($value) {

  echo "<pre>";

  var_dump($value);

  echo "</pre>";

  die();

}

function urlIs($value) {

  return $_SERVER['REQUEST_URI'] === $value;

}

function abort($code = '404') {

  http_response_code($code);

  require BASE_PATH . "controllers/{$code}.php";

  die();

}

function redirectTo(string $path = '/') {
  
  header('Location: /' . $path);

  exit();

}

function abort404() {

  header('Location: /404');

  exit();

  
}


function routeToController($uri, $routes)
{

  if(array_key_exists($uri['path'], $routes)) {

    require $routes[$uri['path']];

  } else {

    require "controllers/404.php";

  }

}

function getCurrentPage() {

  $uri = parse_url($_SERVER['REQUEST_URI']);

  return $uri['path'];
  
}


function assets($path) {

  return BASE_PATH . $path;

}


function view($path) {

  return BASE_PATH . $path;


}

function getAuthorizationHeader()
{

  $headers = null;

  if (isset($_SERVER['Authorization'])) {

      $headers = trim($_SERVER["Authorization"]);

  } else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { //Nginx or fast CGI

      $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);

  } elseif (function_exists('apache_request_headers')) {

      $requestHeaders = apache_request_headers();

      // Server-side fix for bug in old Android versions (a nice side-effect of this fix means we don't care about capitalization for Authorization)
      
      $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders)), array_values($requestHeaders));
      
      if (isset($requestHeaders['Authorization'])) {

          $headers = trim($requestHeaders['Authorization']);

      }
  }

  return $headers;

}

/**
 * get access token from header
 * */
function getBearerToken() 
{

  $headers = getAuthorizationHeader();

  if (!empty($headers)) {
  
    if (preg_match('/Bearer\s(\S+)/', $headers, $matches)) {

        return $matches[1];

    }
  
  }
  
  return null;

}

function successResponse($message = '', $array = []) {

  echo json_encode([

    'status'  => true,

    'message' => $message,

    'data'    => $array

  ], true);

}

function errorResponse($message = '', $array = []) {

  echo json_encode([

    'status'  => false,

    'message' => $message,

    'data'    => $array

  ], true);

}

function getTokenOrfail($status = 401) {

  $token = getBearerToken();

  if(!$token) {

    echo json_encode([
      'status'  => false,
      'message' => '401 Unauthorized.'
    ], true);

    return;

  }

  return $token;
  
}


require_once BASE_PATH . "helpers/index.php";

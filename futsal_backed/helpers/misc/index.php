<?php

//Mthod to validate email
function validateEmail($email) {

      return filter_var($email, FILTER_VALIDATE_EMAIL);

}

//Method to return message
function returnResponse($status, $message, $token = '') {

      $array = [
                  
            'status'   => $status,

            'message'  => $message,

      ];

      if($token) {

            $array['token']  = $token;
      }

      return $array;
}

//Method to make a token
function generateToken($length = 32)
{

    if (function_exists('random_bytes')) {

        $bytes = random_bytes($length / 2);

    } else {

        $bytes = openssl_random_pseudo_bytes($length / 2);

    }

    $randomString = bin2hex($bytes);

    return $randomString;

}


function getExpiryDate() {

      return date('Y-m-d H:i:s',date(strtotime("+1 day", strtotime("2009-09-30 20:24:00"))));

}

//Function to create hourly timeslots
function timeSlots($db, $merchant,  $day, $offdays, $duration = 60, $cleanup = 0, $start = "07:00", $end = "21:00") {

    $start = new DateTime($start);
    $end   = new DateTime($end);
    $interval = new DateInterval("PT" . $duration. "M");
    $cleanupInterval = new DateInterval("PT" . $cleanup. "M");

    //Array to store the time slots
    $slots = [];


    //Loop through the hourly time
    //Eg. 7 - 8 am
    //8 - 10 am
    for($intStart = $start; $intStart < $end; $intStart->add($interval)->add($cleanupInterval)) {
        $endPeriod = clone $intStart;
        
        //Add the defined interval to the current index
        $endPeriod->add($interval);   

        //End the loop if at the last
        if($endPeriod > $end) {
            break;
        }

        //Get the bookings of merchant where date is today 
        //start_time is the current loop time
        //and hasnot cancelled
        $found = $db->query("SELECT * FROM bookings WHERE merchant_id = :merchant AND CONVERT(day, DATE) = :day AND start_time = :start AND  is_cancelled_at IS NULL" , [
                'merchant'  => $merchant,
                'day'       => $day,
                'start'     => $intStart->format("H:i:s"),
        ])->get();



        $array = [

            'date'    =>  $day, 

            'time'    =>  $intStart->format("H:i:a"). "-" . $endPeriod->format("H:i:a"),

            'start'   =>  $intStart->format("H:i"),

            'end'     =>  $endPeriod->format("H:i"),

        ];  

        //Get the offdays of
        //-merchant _id 
        //- IF table has all start_date, end_date , start_time & end_time
        $offdays1 = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant_id AND start_date <= :day AND end_date >= :day2 AND start_time <= :start_time AND end_time >= :end_time", [
            "merchant_id" => $merchant,
            "day"         => $day,
            "day2"        => $day,
            "start_time"  => $intStart->format("H:i:s"),
            "end_time"    => $endPeriod->format("H:i:s"),
        ])->get();


        //Get the offdays if 
        //merchant has only set start_date & end_date
        $offdays2 = $db->query("SELECT * FROM offdays WHERE merchant_id = :merchant_id AND start_date  <= :day AND end_date >= :day2 AND start_time IS NULL AND end_time IS NULL", [
            "merchant_id" => $merchant,
            "day"         => $day,
            "day2"        => $day,
        ])->get();

        //if merchant has off days set the offdays to true
        $isOffDay = (count($offdays1) > 0 
            || count($offdays2) > 0) ? true : false;


        //If the booking has been made in current time slot
        //or if merchant is at off day
        //or if the day 0s today && the ktm time zone hour is > than the current time
        if($found 
            || $isOffDay 
            || ( $day == date("Y-m-d") 
                    && (new DateTime("now", new DateTimeZone("Asia/Kathmandu")))->format("H:i:s") > $intStart->format("H:i:s"))
        ) {

            $array['is_booked'] = true;

        } else {
            


            $array['is_booked'] = false;


        }

        // push the array to the slots
        $slots[] = $array;

    }

    // Return at last
    return $slots;

}


function generateTimeRange($database, $merchant, $from, $to, $offdays)
{


    $date = new DateTime(); 
    $interval = 1;
    // Repeat x times at y day intervals. (Not including the initial)
    $repeatAmount = 2; 
    // Repeat the reminder x times
    // 
    $slots = [];

    for ($i = 0; $i <= $repeatAmount; ++$i) {

        $slots[] = timeSlots($database, $merchant, $date->format("Y-m-d"), $offdays);

        $date->modify('+'. $interval .' day');

    }

    return $slots;


    return $slots;

}




function validate_phone_number($phone)
{
     // Allow +, - and . in phone number
     $filtered_phone_number = filter_var($phone, FILTER_SANITIZE_NUMBER_INT);
     // Remove "-" from number
     $phone_to_check = str_replace("-", "", $filtered_phone_number);

     // Check the lenght of number
     // This can be customized if you want phone number from a specific country
     if (strlen($phone_to_check) < 10 || strlen($phone_to_check) > 14) {
        return false;
     } else {
       return true;
     }
}


function getAllFutsals($db, $token) {

    // if authorixed
    $limit = 10;

    // Current pagination page number
    $page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
    
    // Offset
    $paginationStart = ($page - 1) * $limit;

    try {

        $merchantCount  = $db->query("SELECT COUNT(*) FROM merchants WHERE is_completed = 1")->total();

        $merchantList  = $db->query("SELECT * FROM merchants WHERE is_completed = 1  ORDER BY id DESC LIMIT $paginationStart, $limit ")->get();


        $count = ceil($merchantCount / $limit);

        $modified = [];

        foreach($merchantList as $m) {

            $modified[] = [
                'id'          => (int) $m['id'],
                'banner'      => BASE_URL . $m['banner'],
                'image'       => BASE_URL . $m['image'],
                'name'        => $m['name'],
                'phone'       => $m['phone'],
                'email'       => $m['email'],
                'futsal_name'  => $m['futsal_name'],
                'location'  => $m['location'],
                'price'  => $m['price'],
                'description'  => $m['description'],
                'is_completed'  => (bool) $m['is_completed'],
                'is_available' => true,
                'receivable' => $m['receivable'],
                'start_time'  => $m['start_time'],
                'end_time'  => $m['end_time'],
                'created_at'  => $m['created_at'],
                'updated_at'  => $m['updated_at'],

            ];

        }


        return [

            'status'  => true, 

            'data'    => [
                
                'current_page'  => (int) $page,

                'data'   => $modified,

                'total'  => (int) $merchantCount,

                'pages'  => (int) $count,

            ]

        ];


    } catch (\Exception $e) {

        return returnResponse(false, $e->getMessage());

    }

}

//Create an random string
function getRandomString($n = 10)
{
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $randomString = '';

    for ($i = 0; $i < $n; $i++) {
        $index = rand(0, strlen($characters) - 1);
        $randomString .= $characters[$index];
    }

    return $randomString;
}

// Upload function
function uploadImage($image, $target = "uploads/" )
{
    //Make a distinguishable filename
    $target_file = $target . "img-" . getRandomString() . ".png" ;

    //create directory if defined is not a directory
    if(!is_dir($target)) {  

        mkdir($target); 

    }
    

    //Check if the file is a image
    if(!$image['tmp_name']){
    
        return returnResponse(false, "Image is required.");

    }

    // Check file size
    if ($image["size"] > 500000) {

        return returnResponse(false, "Image is too big.");

    }

    //Move the file
    //if
    if (!move_uploaded_file($image["tmp_name"], $target_file)) {
        
        return returnResponse(false, "Image cannot be uploaded at the moment. Try again later.");

    } 

    // if success reutnr the filename to save to Databse
    return [
        'status' => true,
        'data'   => $target_file
    ];


}



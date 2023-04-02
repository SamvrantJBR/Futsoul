<?php

use Core\Database;

$config  = require BASE_PATH . "/config.php";

$db      = new Database($config['database']);


if(!$_SESSION['id'] && !$_SESSION['username']) {

    header("Location: /");

    exit();

}


if($_SERVER['REQUEST_METHOD'] == 'POST') {

    if(!$_POST['_id'])

        redirectTo("user/list");


    $found    = $db->query("SELECT * FROM users WHERE id = :id AND is_admin IS NULL LIMIT 1", [
                    'id' => (int) trim($_POST['_id'])
                ])->findOrfail();

    if(!$found)
    {
        
        abort404();

    } else {

        $deleted    = $db->query("DELETE FROM users WHERE id = :id AND is_admin IS NULL LIMIT 1", [
                 'id' => $found['id']
            ]);

        if($deleted) {

            $_SESSION['success'] = "User Deleted.";

            redirectTo("user/list");

        } 


    }



}

// abort404();

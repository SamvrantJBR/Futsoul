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

        redirectTo("banner/list");

    
    $found    = $db->query("SELECT * FROM banners WHERE id = :id LIMIT 1", [
                    'id' => (int) trim($_POST['_id'])
                ])->findOrfail();


    if($found) {

        unlink($found['image']);

        $deleted    = $db->query("DELETE FROM banners WHERE id = :id LIMIT 1", [
                        'id' => (int) $_POST['_id']
                    ]);

        if($deleted) {

            $_SESSION['success'] = "Banner Deleted.";

            redirectTo("banner/list");

        }

    } else {
        
        abort404();

    }


}



<?php

function listBanners($db) {

	$limit = 10;

	// Current pagination page number
	$page = (isset($_GET['page']) && is_numeric($_GET['page']) ) ? $_GET['page'] : 1;
	
	// Offset
	$paginationStart = ($page - 1) * $limit;

	try {

		$bannerCount  = $db->query("SELECT COUNT(*) FROM banners")->total();

		$bannerList  = $db->query("SELECT * FROM banners ORDER BY id DESC LIMIT $paginationStart, $limit ")
		->get();


		$count = ceil($bannerCount / $limit);

		return [

			'status'  => true, 

			'data'    => [
				
				'current_page'  => $page,

				'banner'   => $bannerList,

				'total'  => $bannerCount,

				'pages'  => $count,

				'limit'  => $limit

			]

		];


	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}
function addBanner($db)
{

	$image      = $_FILES['image'] ?? null;

	//Check passed image
	if(!$image || !$image['tmp_name']) {

		return returnResponse(false, "Image cannot be null.");

	}


	try {
				
		//Upload the iage	
		$uploaded = uploadImage($_FILES["image"]);

		if (!$uploaded) {
			
			return returnResponse(false, "Image cannot be uploaded at the moment. Try again later.");

		} 

		//All fields
		$fields['image']        = $uploaded['data'];
		$fields['created_at']   = date("Y-m-d H:i:s");


		//Insert into db	
		$db->query("INSERT INTO banners(image, created_at) VALUES(:image, :created_at)", $fields);

		return  [

			'status'  => true,

		];

	} catch (\Exception $e) {

		return returnResponse(false, $e->getMessage());

	}

}







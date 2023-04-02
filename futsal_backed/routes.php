<?php

return [
	"/"                 => BASE_PATH . 'controllers/login.php',
	"/dashboard"        => BASE_PATH . 'controllers/admin/dashboard.php',
	"/reset-password"   => BASE_PATH . 'controllers/admin/reset.php',
	"/merchant/list"     => BASE_PATH . 'controllers/admin/merchant/list.php',
	"/merchant/create"     => BASE_PATH . 'controllers/admin/merchant/create.php',
	"/merchant/show"     => BASE_PATH . 'controllers/admin/merchant/show.php',
	"/merchant/delete"     => BASE_PATH . 'controllers/admin/merchant/delete.php',

	"/user/list"     => BASE_PATH . 'controllers/admin/user/list.php',
	"/user/show"     => BASE_PATH . 'controllers/admin/user/show.php',
	"/user/delete"     => BASE_PATH . 'controllers/admin/user/delete.php',

	"/booking/list"     => BASE_PATH . 'controllers/admin/booking/list.php',
	"/booking/show"     => BASE_PATH . 'controllers/admin/booking/show.php',
	"/booking/delete"     => BASE_PATH . 'controllers/admin/booking/delete.php',

	"/banner/list"     => BASE_PATH . 'controllers/admin/banner/list.php',
	"/banner/create"     => BASE_PATH . 'controllers/admin/banner/create.php',
	"/banner/delete"     => BASE_PATH . 'controllers/admin/banner/delete.php',

	"/payment/list"     => BASE_PATH . 'controllers/admin/payment/list.php',
	"/payment/create"     => BASE_PATH . 'controllers/admin/payment/create.php',
	"/payment/delete"     => BASE_PATH . 'controllers/admin/payment/delete.php',

	"/logout"   => BASE_PATH . 'controllers/admin/logout.php',
	"/404"              => BASE_PATH . 'controllers/404.php',

	"/api/search"   => BASE_PATH . 'controllers/api/search.php',
	"/api/banners" => BASE_PATH . 'controllers/api/list-banners.php',
	"/api/futsals/list"  => BASE_PATH . "controllers/api/list-merchants.php",
	"/api/futsals/show"  => BASE_PATH . "controllers/api/show-merchant.php",
	"/api/futsals/isFutsalAvailable"  =>  BASE_PATH .'controllers/api/available.php',


	"/api/merchant/register"  => BASE_PATH . "controllers/api/merchant/auth/register.php",
	"/api/merchant/login"     => BASE_PATH . "controllers/api/merchant/auth/login.php",
	"/api/merchant/logout"    => BASE_PATH . "controllers/api/merchant/auth/logout.php",
	"/api/merchant/reset-password"    => BASE_PATH . "controllers/api/merchant/auth/reset.php",
	"/api/merchant/forgot-password"    => BASE_PATH . "controllers/api/merchant/auth/forgot.php",
	"/api/merchant/reset-forgot-password"    => BASE_PATH . "controllers/api/merchant/auth/reset-forgot.php",
	"/api/merchant/complete-profile"    => BASE_PATH . "controllers/api/merchant/auth/complete.php",
	"/api/merchant/update"    => BASE_PATH . "controllers/api/merchant/auth/update.php",

	"/api/merchant/active-bookings"  => BASE_PATH . "controllers/api/merchant/booking/active.php",
	"/api/merchant/past-bookings"   => BASE_PATH . "controllers/api/merchant/booking/past.php",

	"/api/merchant/favourites"  => BASE_PATH . "controllers/api/merchant/favourites.php",
	"/api/merchant/incomes"     => BASE_PATH . "controllers/api/merchant/incomes.php",
	"/api/merchant/completeBooking"     => BASE_PATH . "controllers/api/merchant/completeBooking.php",
	"/api/merchant/cancelBooking"     => BASE_PATH . "controllers/api/merchant/cancelBooking.php",

	"/api/merchant/add-booking"     => BASE_PATH . "controllers/api/merchant/booking/create.php",
	"/api/merchant/add-offdays"     => BASE_PATH . "controllers/api/merchant/offdays.php",
	"/api/merchant/list-offdays"     => BASE_PATH . "controllers/api/merchant/list-offdays.php",
	"/api/merchant/delete-offdays"     => BASE_PATH . "controllers/api/merchant/delete-offdays.php",

	"/api/user/register"  => BASE_PATH . "controllers/api/user/auth/register.php",
	"/api/user/login"     => BASE_PATH . "controllers/api/user/auth/login.php",
	"/api/user/logout"    => BASE_PATH . "controllers/api/user/auth/logout.php",
	"/api/user/update-profile"    => BASE_PATH . "controllers/api/user/auth/update.php",
	"/api/user/reset-password"    => BASE_PATH . "controllers/api/user/auth/reset.php",
	"/api/user/forgot-password"    => BASE_PATH . "controllers/api/user/auth/forgot.php",
	"/api/user/reset-forgot-password"    => BASE_PATH . "controllers/api/user/auth/reset-forgot.php",
	"/api/user/bookings"  => BASE_PATH . "controllers/api/user/booking/index.php",
	
	"/api/user/book"  => BASE_PATH . "controllers/api/user/booking/book.php",
	"/api/user/complete-payment"  => BASE_PATH . "controllers/api/user/booking/paymentComplete.php",
	"/api/payment"  => BASE_PATH . "controllers/api/user/booking/paymentResponse.php",
	"/api/user/cancel"  => BASE_PATH . "controllers/api/user/booking/cancel.php",


	"/api/user/favourites"  => BASE_PATH . "controllers/api/user/favourites.php",
	"/api/user/toggle-favourite"  => BASE_PATH . "controllers/api/user/toggleFavourite.php",
	"/api/user/is-favourite"  => BASE_PATH . "controllers/api/user/isFavourite.php",

];





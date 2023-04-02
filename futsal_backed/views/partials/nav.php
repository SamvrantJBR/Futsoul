<header id="sidebar" class="sidebar">
	<div class="sidebar_inner">
		<div class="flex items-center">
			<a href="/" class="px-2 py-2">
				 <img src="/assets/logo.png">

			</a>
		</div>

		<ul class=" sidebar_nav">
			
			<?php if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true) : ?>

				<a href="/dashboard" class="nav-link <?php echo getCurrentPage() == '/dashboard' ? 'active' : ''; ?>">Dashboard</a>   

				<a href="/banner/list" class="nav-link <?php echo (getCurrentPage() == '/banner/list' || getCurrentPage() == '/banner/create') ? 'active' : ''; ?>">Banners</a>   
				<a href="/booking/list" class="nav-link <?php echo (getCurrentPage() == '/booking/list' || getCurrentPage() == "/booking/show") ? 'active' : ''; ?>">Bookings</a>   

				<a href="/merchant/list" class="nav-link <?php echo (getCurrentPage() == '/merchant/list' || getCurrentPage() == '/merchant/create' || getCurrentPage() == "/merchant/show") ? 'active' : ''; ?>">Merchants</a>   

				<a href="/user/list" class="nav-link <?php echo (getCurrentPage() == '/user/list' || getCurrentPage() == '/user/show') ? 'active' : ''; ?>">Users</a>   

				<a href="/payment/list" class="nav-link <?php echo (getCurrentPage() == '/payment/list' || getCurrentPage() == '/payment/create' || getCurrentPage() == '/payment/show') ? 'active' : ''; ?>">Payment</a>   

				<a href="/reset-password" class="nav-link <?php echo getCurrentPage() == '/reset-password' ? 'active' : ''; ?>">Reset Password</a>   

				<a  id="logout" class="logout">Logout</a>

			<form id="logout-form" style="display:none;" method="post" action="/logout">

				<button type="submit" class="logout">Logout</button>

			</form>

			<?php endif; ?>

		</ul>

	</div>
	<div class="sidebar_right">
		<svg
		 	id="cross"
	 		height="32"
	 		width="32"
	      class="text-gray-600"
	      xmlns="http://www.w3.org/2000/svg"
	      fill="none"
	      viewBox="0 0 24 24"
	      stroke="currentColor"
	    >
	      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
	    </svg>
	</div>

</header>


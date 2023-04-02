<?php require  dirname(__DIR__) . "/partials/header.php"; ?>


<!-- component -->
<div class="w-screen screen bg">

	<?php require  dirname(__DIR__) . "/partials/nav.php"; ?>


	<!-- //Checking for success message -->
	<?php if($_SESSION['id'] && $_SESSION['username'] && isset($_SESSION['success'])): ?>

	    <div class="alert alert-success" id="alert">
	        <?php 

	        	echo $_SESSION['success'];

	        	// Unset to remove the message beacause it will show everytime reloaded
	        	unset($_SESSION['success']);
			 ?>
	    </div>

	<?php endif; ?>

	<div class="main flex flex-col flex-1 h-full overflow-hidden">

        <?php require BASE_PATH .  "views/partials/topbar.php"; ?>

        <!-- Main content -->
        <main class="flex-1 ">
			 

			<div class="mb-3 flex breadcrumb">
	            <span class="breadcrumb-link breadcrumb_active">Dashboard</span>
	        </div>

	        <div class="mt-3 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
	        	<div class=" dash_item w-full  mb-3 ">
	        		<h5 class="dash_item__title">Total Merchants</h5>

	        		<span class="dash_item__total">
	        			<?php echo $merchantCount; ?>
	        		</span>
	        	</div>

	        	<div class=" dash_item w-full  mb-3">
	        		<h5 class="dash_item__title">Total Users</h5>

	        		<span class="dash_item__total">
	        			<?php echo $userCount; ?>
	        		</span>
	        	</div>

	        	<div class=" dash_item w-full  mb-3">
	        		<h5 class="dash_item__title">Total Bookings</h5>

	        		<span class="dash_item__total">
	        			<?php echo $bookingCount; ?>
	        		</span>
	        	</div>

				<div class=" dash_item w-full  mb-3 ">
	        		<h5 class="dash_item__title">Total Banners</h5>

	        		<span class="dash_item__total">
	        			<?php echo $bannerCount; ?>
	        		</span>
	        	</div>


				<div class=" dash_item w-full  mb-3 ">
	        		<h5 class="dash_item__title">Total Payments</h5>

	        		<span class="dash_item__total">
	        			<?php echo $paymentCount; ?>
	        		</span>
	        	</div>
	        </div>

		</main>

	</div>

</div>

<?php require dirname(__DIR__) . "/partials/footer.php"; ?>

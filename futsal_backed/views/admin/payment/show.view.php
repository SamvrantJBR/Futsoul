<?php require  BASE_PATH . "/views/partials/header.php"; ?>

<div class="w-screen screen bg">

<?php require  BASE_PATH . "/views/partials/nav.php"; ?>


	<?php if($_SESSION['id'] && $_SESSION['username'] && isset($_SESSION['success'])): ?>

	    <div class="alert alert-success" id="alert">
	        <?php 
	        	echo $_SESSION['success'];
	        	unset($_SESSION['success']);
			 ?>
	    </div>

	<?php endif; ?>

	<div class="main flex flex-col flex-1 h-full overflow-hidden">
        <?php require BASE_PATH .  "views/partials/topbar.php"; ?>
        <!-- Main content -->
        <main class="flex-1 ">
        	
    	<div class="flex mb-3 justify-between items-center">
	        <div class=" flex breadcrumb">
	            <a href="/dashboard" class="breadcrumb-link">Dashboard</a>
	            <span class="separator">/</span>
	          	<a href="/payment/list" class="breadcrumb-link">Payments</a>
	            <span class="separator">/</span>

	            <span class="breadcrumb-link breadcrumb_active">Show Payment</span>
	        </div>

	      	<div class=" flex justify-end items-center breadcrumb">

			</div>
        </div>
         
        <div class="payment_show">
        	
        </div>

	</div>
</main>
</div>

</div>


<?php require BASE_PATH . "/views/partials/footer.php"; ?>

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
	            <span class="breadcrumb-link breadcrumb_active">
	            <a href="/booking/list" class="breadcrumb-link">Bookings</a>
	            <span class="separator">/</span>
	            	<?php echo $data['user_name'] ?  htmlspecialchars($data['user_name']) : ""; ?>
	            </span>	        
	        </div>


	      	<div class=" flex justify-end items-center breadcrumb">
			</div>
        </div>

        <div class="booking_show">

        	<div class="info booking_info">
    			<div class="mb-4 flex input_wrapper ">
					<label for="status" class="w-1/3 label"> Status </label>
					<?php  if($data['status'] == 'completed') : ?>
						<span class="badge badge_success" >
							 Completed 
						</span>
					<?php elseif($data['status'] == 'cancelled'): ?>
						<span class="badge badge_error" >
							  Canceled
						</span>
					<?php elseif($data['status'] == 'pending'): ?>
						<span class="badge badge_warning" >
							  Pending
						</span>
					<?php elseif($data['status'] == 'booked'): ?>
						<span class="badge badge_e" >
							  Booked
						</span>
					<?php endif; ?>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="price" class="w-1/3 label"> Price </label>
					<span class="w-2/3  ">
						Rs <?php echo $data['price'] ?? ''; ?>
					</span>
				</div>


				<div class="mb-4 flex input_wrapper ">
					<label for="phone" class="w-1/3 label"> Play Date </label>
					<span class="w-2/3  ">
						<?php echo $data['day'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="phone" class="w-1/3 label"> Time </label>
					<span class="w-2/3  ">
						<?php echo $data['start_time'] .'-' . $data['end_time']; ?>
					</span>
				</div>



				<div class="mb-4 flex input_wrapper ">
					<label for="type" class="w-1/3 label"> Mode </label>
					<span class="w-2/3  ">
						<?php echo $data['type'] ?? ''; ?>
					</span>
				</div>


			</div>

			<?php if($data['type'] == 'offline'): ?>
	        	<div class="info user_info">
	    			<div class="mb-4 flex input_wrapper ">
						<label for="name" class="w-1/3 label"> User Name </label>
						<span class="w-2/3  ">
							<?php echo $data['full_name'] ?? ''; ?>
						</span>
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="email" class="w-1/3 label"> User Email </label>
						<span class="w-2/3  ">
							<?php echo $data['email'] ?? ''; ?>
						</span>
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="phone" class="w-1/3 label"> User Phone </label>
						<span class="w-2/3  ">
							<?php echo $data['phone'] ?? ''; ?>
						</span>
					</div>

				</div>
			<?php endif; ?>

			<?php if($data['type'] == 'online'): ?>
	        	<div class="info user_info">
	    			<div class="mb-4 flex input_wrapper ">
						<label for="name" class="w-1/3 label"> User Name </label>
						<span class="w-2/3  ">
							<?php echo $data['user_name'] ?? ''; ?>
						</span>
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="email" class="w-1/3 label"> User Email </label>
						<span class="w-2/3  ">
							<?php echo $data['user_email'] ?? ''; ?>
						</span>
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="phone" class="w-1/3 label"> User Phone </label>
						<span class="w-2/3  ">
							<?php echo $data['user_phone'] ?? ''; ?>
						</span>
					</div>

				</div>
			<?php endif; ?>

			<div class="info merchant_info">
    			<div class="mb-4 flex input_wrapper ">
					<label for="name" class="w-1/3 label"> Merchant Name </label>
					<span class="w-2/3  ">
						<?php echo $data['merchant_name'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="email" class="w-1/3 label"> Merchant Email </label>
					<span class="w-2/3  ">
						<?php echo $data['merchant_email'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="phone" class="w-1/3 label"> Merchant Phone </label>
					<span class="w-2/3  ">
						<?php echo $data['merchant_phone'] ?? ''; ?>
					</span>
				</div>

			</div>


        </div>





    </main>
</div>
	</div>

</div>


<?php require BASE_PATH . "/views/partials/footer.php"; ?>

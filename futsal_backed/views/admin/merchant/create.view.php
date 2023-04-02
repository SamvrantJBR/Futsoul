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
        	
        <div class="mb-3 flex breadcrumb">
            <a href="/dashboard" class="breadcrumb-link">Dashboard</a>
            <span class="separator">/</span>
            <a href="/merchant/list" class="breadcrumb-link">Merchants</a>
            <span class="separator">/</span>
            <span class="breadcrumb-link breadcrumb_active">New Merchant</span>
        </div>
            

		<?php if($error): ?>

			<div class="alert alert-danger" id="alert">
				<?php echo $error;  ?>
            </div>

		<?php endif; ?>

		<?php if($success): ?>

			<div class="alert alert-success" id="alert">
				<?php echo $success;  ?>
            </div>

		<?php endif; ?>


		<!-- Form -->
		<form method="POST" enctype="multipart/form-data">
			<div class="personal">

				<div class="personal_left">
					<h3 class="title" >Personal Info</h3>
				</div>

				<div class="personal_right">
					<div class="mb-4 flex input_wrapper ">
						<label for="name" class="w-1/3 label">Name <span class="required">*</span></label>
						<input type="text" name="name" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['name']) ? 'border-red-600' : 'border-gray-900'; ?>"
							value="<?php echo $data['name'] ?? ''; ?>" />
					</div>



							<div class="mb-4 flex input_wrapper ">
						<label for="email" class="w-1/3 label">Email <span class="required">*</span></label>
						<input type="email" name="email" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['email']) ? 'border-red-600' : 'border-gray-900'; ?>"
							value="<?php echo $data['email'] ?? ''; ?>" />
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="phone" class="w-1/3 label">Phone <span class="required">*</span></label>
						<input type="number" name="phone" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['phone']) ? 'border-red-600' : 'border-gray-900'; ?>"
							value="<?php echo $data['phone'] ?? ''; ?>" />
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="image" class="w-1/3 label">Profile Image <span class="required">*</span></label>
						<input type="file" name="image" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['image']) ? 'border-red-600' : 'border-gray-900'; ?>"
							 />
					</div>


				</div>

			</div>


			<div class="futsal">

				<div class="futsal_left">
					<h3 class="title" >Futsal Info</h3>
				</div>

				<div class="futsal_right">
					<div class="mb-4 flex input_wrapper ">
						<label for="futsal_name" class="w-1/3 label">Futsal Name <span class="required">*</span></label>
						<input type="text" name="futsal_name" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['futsal_name']) ? 'border-red-600' : 'border-gray-900'; ?>"
							value="<?php echo $data['futsal_name'] ?? ''; ?>" />
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="location" class="w-1/3 label">Futsal Location <span class="required">*</span></label>
						<input type="text" name="location" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['location']) ? 'border-red-600' : 'border-gray-900'; ?>"
							value="<?php echo $data['location'] ?? ''; ?>" />
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="price" class="w-1/3 label">Futsal Price Rs<span class="required">*</span></label>
						<input type="number" name="price" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['price']) ? 'border-red-600' : 'border-gray-900'; ?>"
							value="<?php echo $data['price'] ?? ''; ?>" />
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="start_time" class="w-1/3 label">Start Time<span class="required">*</span></label>
						<input type="time" name="start_time" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['start_time']) ? 'border-red-600' : 'border-gray-900'; ?>"
							value="<?php echo $data['start_time'] ?? ''; ?>" />
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="end_time" class="w-1/3 label">End Time <span class="required">*</span></label>
						<input type="time" name="end_time" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['end_time']) ? 'border-red-600' : 'border-gray-900'; ?>"
							value="<?php echo $data['end_time'] ?? ''; ?>" />
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="banner" class="w-1/3 label">Banner Image <span class="required">*</span></label>
						<input type="file" name="banner" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['banner']) ? 'border-red-600' : 'border-gray-900'; ?>"
							 />
					</div>

					<div class="mb-4 flex input_wrapper ">
						<label for="note" class="w-1/3 label">Description </label>
						<textarea type="text" name="description" class="w-2/3 border border-gray-900 px-2 py-2 rounded" rows="3">
							<?php echo $data['description'] ?? ''; ?>
						</textarea>
					</div>
				</div>
			</div>

			<div class="mb-3 form_action">
				<div></div>
				<button type="submit" class="w-2/3  text-white merchant-save-btn">Create Merchant </button>
			</div>
		</form>
</main>
</div>
	</div>

</div>


<?php require BASE_PATH . "/views/partials/footer.php"; ?>

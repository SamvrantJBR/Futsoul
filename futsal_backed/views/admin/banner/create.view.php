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
            <a href="/banner/list" class="breadcrumb-link">Banners</a>
            <span class="separator">/</span>
            <span class="breadcrumb-link breadcrumb_active">New Banner</span>
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

			<div class="futsal">

				<div class="futsal_left">
					<h3 class="title" >Image</h3>
				</div>

				<div class="futsal_right">

					<div class="mb-4 flex input_wrapper ">
						<input type="file" name="image" 
							class="w-2/3 border  px-2 py-2 rounded 
							<?php echo isset($messages['image']) ? 'border-red-600' : 'border-gray-900'; ?>"
							 />
					</div>


				</div>
			</div>

			<div class="mb-3 form_action">
				<div></div>
				<button type="submit" class="w-2/3  text-white merchant-save-btn">
					Upload Banner
				</button>
			</div>
		</form>
</main>
</div>
	</div>

</div>


<?php require BASE_PATH . "/views/partials/footer.php"; ?>

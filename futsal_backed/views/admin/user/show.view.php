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
	            <a href="/user/list" class="breadcrumb-link">Users</a>
	            <span class="separator">/</span>
	            <span class="breadcrumb-link breadcrumb_active">
	            	<?php echo $data['name'] ?  htmlspecialchars($data['name']) : ""; ?>
	            </span>	        
	        </div>


	      	<div class=" flex justify-end items-center breadcrumb">
			</div>
        </div>

        <div class="show_div">

        	<div class="show_left">

        		<?php if($data['image']): ?>
        			<img src="<?php echo BASE_URL . htmlspecialchars($data['image']); ?>"
	        			class="show_image" />
				<?php else: ?>
					<svg width="100" height="100" viewBox="0 0 24 16" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M11.4668 9.59797C12.4607 9.59797 13.2662 10.4036 13.2662 11.3974V12.1323C13.2662 12.5911 13.1229 13.0383 12.8561 13.4116C11.6191 15.1425 9.59934 16 6.86269 16C4.1254 16 2.10667 15.1422 0.872716 13.4103C0.607101 13.0375 0.464355 12.5912 0.464355 12.1335V11.3974C0.464355 10.4036 1.26998 9.59797 2.26377 9.59797H11.4668ZM6.86269 0C9.07221 0 10.8634 1.79118 10.8634 4.00072C10.8634 6.21026 9.07221 8.00145 6.86269 8.00145C4.65313 8.00145 2.86194 6.21026 2.86194 4.00072C2.86194 1.79118 4.65313 0 6.86269 0Z" fill="#777986"/>
					</svg>

        		<?php endif;?>

        
        	</div>

        	<div class="show_right">

    			<div class="mb-4 flex input_wrapper ">
					<label for="name" class="w-1/3 label">Name </label>
					<span class="w-2/3  ">
						<?php echo $data['name'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="email" class="w-1/3 label">Email </label>
					<span class="w-2/3  ">
						<?php echo $data['email'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="phone" class="w-1/3 label">Phone </label>
					<span class="w-2/3  ">
						<?php echo $data['phone'] ?? ''; ?>
					</span>
				</div>


        	</div>

        </div>



         <div class="overflow-x-scroll mt-6 w-full ">
         	<div class="form-">
        		<h5 class="heading" style="margin:0; padding:0;">Bookings</h5>
	        </div>
	        <table class=" table text-left w-full text-sm font-light">
	          	<thead class="table_head border-b font-medium dark:border-neutral-50">
		            <tr>
		              <th scope="col" class="px-6 py-4">#</th>
		              <th scope="col" class="px-6 py-4">Status</th>
		              <th scope="col" class="px-6 py-4">Name</th>
		              <th scope="col" class="px-6 py-4">Email</th>
		              <th scope="col" class="px-6 py-4">Phone</th>
		              <th scope="col" class="px-6 py-4">Created At</th>
		              <th scope="col" class="px-6 py-4">Action</th>
		            </tr>
	          	</thead>
	          	<tbody>

		          	<?php foreach($data['bookings'] ?? [] as $key => $booking): ?>
		    			<tr class="tr w-full border-b dark:border-neutral-500">
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $booking['id']; ?>
		    				</td>
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php  if($booking['status'] == 'completed') : ?>
		    						<span class="badge badge_success" >
		    							 Completed 
		    						</span>
		    					<?php elseif($booking['status'] == 'cancelled'): ?>
		    						<span class="badge badge_error" >
		    							  Canceled
		    						</span>
		    					<?php elseif($booking['status'] == 'pending'): ?>
		    						<span class="badge badge_warning" >
		    							  Pending
		    						</span>
		    					<?php elseif($booking['status'] == 'booked'): ?>
		    						<span class="badge badge_e" >
		    							  Booked
		    						</span>
		    					<?php endif; ?>
		    				</td>

		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $booking['merchant_name']; ?>
		    				</td>
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<a href="/merchant/show?id=<?php echo $booking['merchant_id']; ?>"><?php echo $booking['merchant_email']; ?></a>
		    				</td>
		    				        				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $booking['merchant_phone'] != 0 ? $booking['merchant_phone'] : ""; ?>
		    				</td>
		    				        				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $booking['created_at']; ?>
		    				</td>

		    				 <td class="tr_td whitespace-nowrap py-4 flex justify-center items-center" >
		    					<a
		    						class="mx-2 icon-link"
									 href="/booking/show?id=<?php echo $booking['id']; ?>">
		    						<img src="/assets/eye.svg" class="icon-sm">
		    					</a>

		    				</td>
		    			</tr>
	    			<?php endforeach; ?>

	          	</tbody>

	        </table>

	       	<?php if(count($data['bookings']) <= 0): ?> 
	        	<div class="flex justify-center items-center">
	        		No Bookings yet
	        	</div>
	        <?php endif; ?>	        

	    </div>

        <div class="mt-3 flex flex-col justify-center items-center pagination">
	        <div class="">
	        	<?php for($i = 1; $i <= $data['pages']; $i++): ?>
	        		<a href="/merchant/show?id=<?php echo htmlspecialchars($data['id']); ?>&page=<?php echo $i; ?>"
	        			class="px-2 py-2 pagination_link <?php echo $data['current_page'] == $i ? 'active_pagination' : ''; ?>">
	        			<?php echo $i; ?>
	        		</a>
	        	<?php endfor; ?>
	        </div>

	        <?php if(count($data['bookings']) > 0): ?>
        	<p class="w-full text-center mt-2 total_pagination">
        		Showing <?php echo count($data['bookings']); ?> 
        		<span class="separator_pagination">of</span>
        		<?php echo $data['total']; ?>
        			
        	</p>
	        <?php endif; ?>

        </div>

    </main>
</div>
	</div>

</div>


<?php require BASE_PATH . "/views/partials/footer.php"; ?>

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
	            <a href="/merchant/list" class="breadcrumb-link">Merchants</a>
	            <span class="separator">/</span>
	            <span class="breadcrumb-link breadcrumb_active">
	            	<?php echo $data['merchant']['futsal_name'] ?? ""; ?>
	            </span>	        
	        </div>


	      	<div class=" flex justify-end items-center breadcrumb">
			</div>
        </div>

        <?php if(!$data['merchant']['banner']): ?>
	        <img class="merchant_banner" src="<?php echo BASE_URL . "assets/bg-placeholder.png" ; ?>" />
	    <?php else: ?>
	    	<img class="merchant_banner" src="<?php echo BASE_URL . $data['merchant']['banner'] ; ?>" />

	    <?php endif; ?>

        <div class="show_div">

        	<div class="show_left">

        		<?php if($data['merchant']['image']): ?>
        			<img src="<?php echo BASE_URL . htmlspecialchars($data['merchant']['image']); ?>"
	        			class="show_image" />
				<?php else: ?>
					<svg width="100" height="100" viewBox="0 0 24 16" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M11.4668 9.59797C12.4607 9.59797 13.2662 10.4036 13.2662 11.3974V12.1323C13.2662 12.5911 13.1229 13.0383 12.8561 13.4116C11.6191 15.1425 9.59934 16 6.86269 16C4.1254 16 2.10667 15.1422 0.872716 13.4103C0.607101 13.0375 0.464355 12.5912 0.464355 12.1335V11.3974C0.464355 10.4036 1.26998 9.59797 2.26377 9.59797H11.4668ZM6.86269 0C9.07221 0 10.8634 1.79118 10.8634 4.00072C10.8634 6.21026 9.07221 8.00145 6.86269 8.00145C4.65313 8.00145 2.86194 6.21026 2.86194 4.00072C2.86194 1.79118 4.65313 0 6.86269 0Z" fill="#777986"/>
					</svg>

        		<?php endif;?>

        	
    			 <?php if($data['merchant']['is_completed']): ?>
    				<span class="complete profile_status" >Profile Completed</span>
    			<?php else: ?>
    				<span class="incomplete profile_status" >Incomplete Profile</span>
    			<?php endif; ?>
        		
        		<div class="earning mt-3 w-full">

		        	<div class="earning_inner">
		        		<div class="earning_type mb-2 w-full flex justify-between items-center">
		        			<label for="" class="">Total Booked</label>
		        			<span class="earning_" style="background:orange; color:#fff; padding: 4px; border-radius: 8px;">Rs. <?php echo $data['total_booked'][0]['income'] ?? "0"; ?></span>
		        		</div>

						<div class="earning_type mb-2 w-full flex justify-between items-center">
		        			<label for="" class="">Total Cancelled</label>
		        			<span class="earning_" style="background:red; color:#fff; padding: 4px; border-radius: 8px;">Rs. <?php echo $data['total_cancel'][0]['income'] ?? "0"; ?></span>
		        		</div>

						<div class="earning_type mb-2 w-full flex justify-between items-center">
		        			<label for="" class="">Total Completed</label>
		        			<span class="earning_" style="background:green; color:#fff; padding: 4px; border-radius: 8px;">Rs. <?php echo $data['total_completed'][0]['income'] ?? "0"; ?></span>
		        		</div>

		        		<div class="earning_type mb-2 w-full flex justify-between items-center">
		        			<label for="" class="">Total Receivable</label>
		        			<span class="earning_" style="background:green; color:#fff; padding: 4px; border-radius: 8px;">Rs. <?php echo $data['merchant']['receivable'] ?? "0"; ?></span>
		        		</div>
		        	</div>
		        </div>

        	</div>


        	<div class="show_right">

    			<div class="mb-4 flex input_wrapper ">
					<label for="name" class="w-1/3 label">Name </label>
					<span class="w-2/3  ">
						<?php echo $data['merchant']['name'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="email" class="w-1/3 label">Email </label>
					<span class="w-2/3  ">
						<?php echo $data['merchant']['email'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="phone" class="w-1/3 label">Phone </label>
					<span class="w-2/3  ">
						<?php echo $data['merchant']['phone'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="futsal_name" class="w-1/3 label">Futsal Name </label>
					<span class="w-2/3 border   rounded ">
						<?php echo $data['merchant']['futsal_name'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="futsal_location" class="w-1/3 label">Location </label>
					<span class="w-2/3 border   rounded ">
						<?php echo $data['merchant']['location'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="price" class="w-1/3 label">Futsal Price </label>
					<span class="w-2/3 border   rounded ">
						Rs. <?php echo $data['merchant']['price'] ?? ''; ?>
					</span>
				</div>

				<div class="mb-4 flex input_wrapper ">
					<label for="description" class="w-1/3 label">Description </label>
					<div class="w-full border   rounded ">
						<?php echo $data['merchant']['description'] ? ($data['merchant']['description']) : ''; ?>
					</div>
				</div>

        	</div>

        </div>



         <div class="overflow-x-scroll mt-6 w-full ">
         	<h5 class="">Bookings</h5>
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
		    					<?php elseif($booking['status'] == 'failed'): ?>
		    						<span class="badge badge_error" >
		    							  Failed
		    						</span>
		    					<?php elseif($booking['status'] == 'pending'): ?>
		    						<span class="badge badge_warning" >
		    							  Pending
		    						</span>
		    					<?php else: ?>
		    						<span class="badge badge_e" >
		    							  Error
		    						</span>
		    					<?php endif; ?>
		    				</td>

		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php if($booking['type'] == 'online'): echo $booking['user_name']; ?>

		    					<?php else: echo $booking['full_name']; endif; ?>
		    				</td>
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php if($booking['type'] == 'online'): echo $booking['user_email']; ?>

		    					<?php else: echo $booking['email']; endif; ?>		    	
		    				</td>
		    				
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php if($booking['type'] == 'online'): echo $booking['user_phone']; ?>

		    					<?php else: echo $booking['phone']; endif; ?>			    				
		    				</td>

		    				<td class="whitespace-nowrap px-6 py-4 font-medium">

		    					<?php  echo $booking['created_at'];  ?>			    				
		    				</td>

		    				 <td class="tr_td whitespace-nowrap py-4 flex items-center" >
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
	        		<a href="/merchant/show?id=<?php echo htmlspecialchars($data['merchant']['id']); ?>&page=<?php echo $i; ?>"
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

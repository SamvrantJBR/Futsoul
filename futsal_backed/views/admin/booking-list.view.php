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
	            <span class="breadcrumb-link breadcrumb_active">Bookings</span>
	        </div>

	      	<div class=" flex justify-end items-center breadcrumb">

			</div>
        </div>
         
        <div class="overflow-x-scroll mt-6 ">

	        <table class="w-full table text-left text-sm font-light">
	          	<thead class="table_head border-b font-medium dark:border-neutral-50">
		            <tr>
		              <th scope="col" class="px-6 py-4">#</th>
		              <th scope="col" class="px-6 py-4">Type</th>
		              <th scope="col" class="px-6 py-4">Status</th>
		              <th scope="col" class="px-6 py-4">Name</th>
		              <th scope="col" class="px-6 py-4">Email</th>
		              <th scope="col" class="px-6 py-4">Phone</th>
		              <th scope="col" class="px-6 py-4">Created At</th>
		              <th scope="col" class="px-6 py-4">Action</th>
		            </tr>
	          	</thead>
	          	<tbody>

		          	<?php foreach($data['data'] ?? [] as $key => $booking): ?>
		    			<tr class="tr w-full border-b dark:border-neutral-500">
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $key + 1; ?>
		    				</td>

		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo htmlspecialchars($booking['type']); ?>
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
		    					<?php echo $booking['created_at']; ?>
		    				</td>

		    				 <td class="tr_td whitespace-nowrap py-4 flex justify-center items-center" >
		    					<a
		    						class="mx-2 icon-link"
									 href="/booking/show?id=<?php echo $booking['id']; ?>">
		    						<img src="/assets/eye.svg" class="icon-sm">
		    					</a>
		    							    					<a 
		    						id=""
		    						class="deleteLink mx-2 icon-link"
		    						href="/booking/delete?id=<?php echo $booking['id']; ?>">
		    						<img src="/assets/trash.svg" class="icon-sm text-red-600">
		    					</a>
		    					<form id="" style="display:none;" method="post" action="/booking/delete" class="deleteForm">
		    						<input type="hidden" name="_id" value="<?php echo $booking['id']; ?>" />
		    						<button type="submit" value="Submit">Submit</button>
		    					</form>	
		    					
		    				</td>
		    			</tr>
	    			<?php endforeach; ?>

	          	</tbody>

	        </table>

	       	<?php if(count($data['data']) <= 0): ?> 
	        	<div class="flex justify-center items-center">
	        		No Bookings Available.
	        	</div>
	        <?php endif; ?>
	    </div>

        <div class="mt-3 flex flex-col justify-center items-center pagination">
	        <div class="">
	        	<?php for($i = 1; $i <= $data['pages']; $i++): ?>
	        		<a href="/booking/list?page=<?php echo $i; ?>"
	        			class="px-2 py-2 pagination_link <?php echo $data['current_page'] == $i ? 'active_pagination' : ''; ?>">
	        			<?php echo $i; ?>
	        		</a>
	        	<?php endfor; ?>
	        </div>

	        <?php if(count($data['data']) > 0): ?>
        	<p class="w-full text-center mt-2 total_pagination">
        		Showing <?php echo count($data['data']); ?> 
        		<span class="separator_pagination">of</span>
        		<?php echo $data['total']; ?>
        			
        	</p>
	        <?php endif; ?>

        </div>

	</div>
</main>
</div>

</div>


<?php require BASE_PATH . "/views/partials/footer.php"; ?>

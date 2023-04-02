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
	            <span class="breadcrumb-link breadcrumb_active">Payments</span>
	        </div>

	      	<div class=" flex justify-end items-center breadcrumb">
	      		<a href="/payment/create"  class="new_merchant flex items-center">
	      			<img src="/assets/plus.svg" class="icon-sm">
					<span class="ml-2 text-md">New Payment</span>
	      		</a>
			</div>        </div>
         
        <div class="overflow-x-scroll mt-6 ">

	        <table class="w-full table text-left text-sm font-light">
	          	<thead class="table_head border-b font-medium dark:border-neutral-50">
		            <tr>
		              <th scope="col" class="px-6 py-4">#</th>
		              <th scope="col" class="px-6 py-4">Merchant Eamil</th>
		              <th scope="col" class="px-6 py-4">Merchant Phone</th>
		              <th scope="col" class="px-6 py-4">Amount</th>
		              <th scope="col" class="px-6 py-4">Created At</th>
		              <th scope="col" class="px-6 py-4">Action</th>
		            </tr>
	          	</thead>
	          	<tbody>

		          	<?php foreach($data['data'] ?? [] as $key => $payment): ?>
		    			<tr class="tr w-full border-b dark:border-neutral-500">
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $payment['id'] + 1; ?>
		    				</td>

		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<a href="/merchant/show?id=<?php echo htmlentities($payment['merchant_id']); ?>">
		    						<?php echo htmlspecialchars($payment['merchant_email']); ?>
		    					</a>
		    				</td>
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $payment['merchant_phone'] ? htmlspecialchars($payment['merchant_phone']) : ""; ?>
		    				</td>



		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					Rs. <?php echo htmlspecialchars($payment['price']); ?>
		    				</td>

		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo htmlspecialchars($payment['created_at']); ?>
		    				</td>

		    				 <td class="tr_td whitespace-nowrap py-4 flex justify-center items-center" >

		    					<a
		    						class="mx-2 icon-link deleteLink"
									 href="/payment/delete?id=<?php echo $payment['id']; ?>">
		    						<img src="/assets/trash.svg" class="icon-sm">
		    					</a>
		    					<form id="" style="display:none;" method="post" action="/payment/delete" class="deleteForm">
		    						<input type="hidden" name="_id" value="<?php echo $payment['id']; ?>" />
		    						<button type="submit" value="Submit">Submit</button>
		    					</form>	
		    				</td>
		    			</tr>
	    			<?php endforeach; ?>

	          	</tbody>

	        </table>

	       	<?php if(count($data['data']) <= 0): ?> 
	        	<div class="flex justify-center items-center">
	        		No Payments yet
	        	</div>
	        <?php endif; ?>

	    </div>

        <?php if(isset($data['pages'])): ?>
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
	    <?php endif; ?>

	</div>
</main>
</div>

</div>


<?php require BASE_PATH . "/views/partials/footer.php"; ?>

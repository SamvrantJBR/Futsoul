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
	            <span class="breadcrumb-link breadcrumb_active">Users</span>
	        </div>

	      	<div class=" flex justify-end items-center breadcrumb">

			</div>
        </div>
         
        <div class="overflow-x-scroll w-full mt-6 ">

	        <table class="w-full table text-left text-sm font-light">
	          	<thead class="table_head border-b font-medium dark:border-neutral-50">
		            <tr>
		              <th scope="col" class="px-6 py-4">#</th>
		              <th scope="col" class="px-6 py-4">Name</th>
		              <th scope="col" class="px-6 py-4">Email</th>
		              <th scope="col" class="px-6 py-4">Phone</th>
		              <th scope="col" class="px-6 py-4">Created At</th>
		              <th scope="col" class="px-6 py-4">Action</th>
		            </tr>
	          	</thead>
	          	<tbody>

		          	<?php foreach($data['data'] ?? [] as $key => $user): ?>
		    			<tr class="tr w-full border-b dark:border-neutral-500">
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $key + 1; ?>
		    				</td>

		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $user['name']; ?>
		    				</td>
		    				        				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $user['email']; ?>
		    				</td>
		    				        				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $user['phone'] != 0 ? $user['phone'] : ""; ?>
		    				</td>
		    				        				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $user['created_at']; ?>
		    				</td>

		    				 <td class="tr_td whitespace-nowrap px-6 py-4 flex items-center" >
		    					<a
		    						class="mx-2 icon-link"
									 href="/user/show?id=<?php echo $user['id']; ?>">
		    						<img src="/assets/eye.svg" class="icon-sm">
		    					</a>

		    					<a 
		    						id=""
		    						class="deleteLink mx-2 icon-link"
		    						href="/user/delete?id=<?php echo $user['id']; ?>">
		    						<img src="/assets/trash.svg" class="icon-sm text-red-600">
		    					</a>
		    					<form id="" style="display:none;" method="post" action="/user/delete" class="deleteForm">
		    						<input type="hidden" name="_id" value="<?php echo $user['id']; ?>" />
		    						<button type="submit" value="Submit">Submit</button>
		    					</form>
		    				</td>
		    			</tr>
	    			<?php endforeach; ?>

	          	</tbody>

	        </table>

	       	<?php if(count($data['data']) <= 0): ?> 
	        	<div class="flex justify-center items-center">
	        		No Users Available
	        	</div>
	        <?php endif; ?>

	    </div>

        <div class="mt-3 flex flex-col justify-center items-center pagination">
	        <div class="">
	        	<?php for($i = 1; $i <= $data['pages']; $i++): ?>
	        		<a href="/user/list?page=<?php echo $i; ?>"
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
    </main>
</div>
	</div>

</div>


<?php require BASE_PATH . "/views/partials/footer.php"; ?>

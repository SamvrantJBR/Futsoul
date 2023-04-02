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
	            <span class="breadcrumb-link breadcrumb_active">Banners</span>
	        </div>

	      	<div class=" flex justify-end items-center breadcrumb">
	      		<a href="/banner/create"  class="new_merchant flex items-center">
	      			<img src="/assets/plus.svg" class="icon-sm">
					<span class="ml-2 text-md">New Banner</span>
	      		</a>
			</div>
        </div>
         
        <div class="table_wrapper mt-6 ">

	        <table class="w-full table text-left text-sm font-light">
	          	<thead class="table_head border-b font-medium dark:border-neutral-50">
		            <tr>
		              <th scope="col" class="px-6 py-4">#</th>

		              <th scope="col" class="px-6 py-4">Image</th>
		              <th scope="col" class="px-6 py-4">Action</th>
		            </tr>
	          	</thead>
	          	<tbody>

		          	<?php foreach($data['banner'] ?? [] as $key => $banner): ?>
		    			<tr class="tr w-full border-b dark:border-neutral-500">
		    				<td class="whitespace-nowrap px-6 py-4 font-medium">
		    					<?php echo $key + 1; ?>
		    				</td>


		    				<td class="whitespace-nowrap px-6 py-4 font-medium">

				        		<?php if($banner['image']): ?>
				        			<img src="<?php echo BASE_URL . htmlspecialchars($banner['image']); ?>"
					        			class="show_image" />
								<?php else: ?>
									<svg width="100" height="100" viewBox="0 0 24 16" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path d="M11.4668 9.59797C12.4607 9.59797 13.2662 10.4036 13.2662 11.3974V12.1323C13.2662 12.5911 13.1229 13.0383 12.8561 13.4116C11.6191 15.1425 9.59934 16 6.86269 16C4.1254 16 2.10667 15.1422 0.872716 13.4103C0.607101 13.0375 0.464355 12.5912 0.464355 12.1335V11.3974C0.464355 10.4036 1.26998 9.59797 2.26377 9.59797H11.4668ZM6.86269 0C9.07221 0 10.8634 1.79118 10.8634 4.00072C10.8634 6.21026 9.07221 8.00145 6.86269 8.00145C4.65313 8.00145 2.86194 6.21026 2.86194 4.00072C2.86194 1.79118 4.65313 0 6.86269 0Z" fill="#777986"/>
									</svg>

				        		<?php endif;?>

        				   </td>


		    				 <td class="tr_td whitespace-nowrap py-4 flex justify-center items-center" >
		    					<a 
		    						id=""
		    						class="deleteLink mx-2 icon-link"
		    						href="/banner/delete?id=<?php echo $banner['id']; ?>">
		    						<img src="/assets/trash.svg" class="icon-sm text-red-600">
		    					</a>
		    					<form id="" style="display:none;" method="post" action="/banner/delete" class="deleteForm">
		    						<input type="hidden" name="_id" value="<?php echo $banner['id']; ?>" />
		    						<button type="submit" value="Submit">Submit</button>
		    					</form>
		    				</td>
		    			</tr>
	    			<?php endforeach; ?>

	          	</tbody>

	        </table>

	       	<?php if(count($data['banner']) <= 0): ?> 
	        	<div class="flex justify-center items-center">
	        		No Banner Available.
	        	</div>
	        <?php endif; ?>

	    </div>


        <div class="mt-3 flex flex-col justify-center items-center pagination">
	        <div class="">
	        	<?php for($i = 1; $i <= $data['pages']; $i++): ?>
	        		<a href="/banner/list?page=<?php echo $i; ?>"
	        			class="px-2 py-2 pagination_link <?php echo $data['current_page'] == $i ? 'active_pagination' : ''; ?>">
	        			<?php echo $i; ?>
	        		</a>
	        	<?php endfor; ?>
	        </div>

	        <?php if(count($data['banner']) > 0): ?>
        	<p class="w-full text-center mt-2 total_pagination">
        		Showing <?php echo count($data['banner']); ?> 
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

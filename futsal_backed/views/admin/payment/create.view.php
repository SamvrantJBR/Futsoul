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

	<?php if(isset($_SESSION['error']) &&$_SESSION['error']): ?>

	    <div class="alert alert-danger" id="alert">
	        <?php 
	        	echo $_SESSION['error'];
	        	unset($_SESSION['error']);
			 ?>
	    </div>

	<?php endif; ?>

	<div class="main flex flex-col flex-1 h-full overflow-hidden">
        <?php require BASE_PATH .  "views/partials/topbar.php"; ?>
        <!-- Main content -->
        <main class="flex-1 max-h-full p-5">
        	
    	<div class="flex mb-3 justify-between items-center">
	        <div class=" flex breadcrumb">
	            <a href="/dashboard" class="breadcrumb-link">Dashboard</a>
	            <span class="separator">/</span>
	          	<a href="/payment/list" class="breadcrumb-link">Payments</a>
	            <span class="separator">/</span>

	            <span class="breadcrumb-link breadcrumb_active">New Payment</span>
	        </div>

	      	<div class=" flex justify-end items-center breadcrumb">

			</div>
        </div>
         
        <div class="payment_create">
        	<form method="post" action="/payment/create" id="payment-form">
        	<div class="personal">

                <div class="personal_left">
                    <h3 class="title" >Create Payment</h3>
                </div>

                <div class="">
	                <div class="mb-4 flex flex-col">

	                    <label for="merchant" class="label">Select Merchant</label>
	                    <select id="merchant" name="merchant" 
	                        class=" border  px-2 py-2 rounded 
	                        ">
	                        <option value="">Select Merchant</option>
	                        <?php foreach($merchants as $merchant):

	                        	?>

	                        	<option value="<?php echo htmlspecialchars($merchant['id']); ?>">
	                        		<?php 
	                        			echo  htmlspecialchars($merchant['name']) . "-" . htmlspecialchars($merchant['futsal_name']); ?>
	                        	</option>

	                        <?php endforeach; ?>
	                    </select>
	                </div>

	                <div  class="mb-4 flex flex-col">

	                    <label for="price" class="label">Receivable By Merchant in (Rs)</label>
	                    <input 
	                    	id="price" 
	                    	min="0"
	                    	name="price" 
	                    	type="number"
	                        class=" border  px-2 py-2 rounded bg-white
	                        "
	                        placeholder="Receivable" 
	                        value=""/>

	                </div>

	                <div  class="mb-4 flex flex-col">

	                    <label for="booking" class="label">Merchant Email</label>
	                    <input 
	                    	id="merchantField" 
	                    	name="" 
	                        class=" border  px-2 py-2 rounded bg-white
	                        "
	                        disabled="disabled" placeholder="Merchant" 
	                        value=""/>

	                </div>
					<div  class="mb-4 flex flex-col">

	                    <label for="booking" class="label">Merchant Phone</label>
	                    <input 
	                    	id="phone" 
	                    	name="" 
	                        class=" border  px-2 py-2 rounded bg-white
	                        "
	                        disabled="disabled" placeholder="Merchant Phone" 
	                        value=""/>

	                </div>

               </div>


           </div>

            <div class="mb-3 form_action">
                <div></div>                
                <button type="submit" class="px-10 py-2 rounded login_btn w-48 text-white">Add </button>
            </div>

        </div>

    </form>

	</div>
</main>
</div>

</div>




<script>

	document.addEventListener('DOMContentLoaded', function() {

		//Convert json string into array 
		let merchantsArray = JSON.parse(`<?php echo $mJson; ?>`);

		//Getting the select 
		//And when it changes
		//then we grab the select value
		document.getElementById("merchant").addEventListener("change", (e) => {
			
			//Getting the mmerchant which id matches the selected option value i.e id
			const merchant = merchantsArray?.filter((b, index) => {
				return b.id == e.target.value;
			})

			// Get the input and setting the input
			document.getElementById("merchantField").value = merchant[0]?.email;
			document.getElementById("phone").value = merchant[0]?.phone;
			document.getElementById("price").value = merchant[0]?.receivable;


		})
	})

</script>

<?php require BASE_PATH . "/views/partials/footer.php"; ?>

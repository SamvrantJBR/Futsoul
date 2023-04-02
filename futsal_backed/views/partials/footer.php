<script src="https://code.jquery.com/jquery-3.6.3.slim.js" integrity="sha256-DKU1CmJ8kBuEwumaLuh9Tl/6ZB6jzGOBV/5YpNE2BWc=" crossorigin="anonymous"></script>
<script>

	//if all document contents are loaded
	//then call the callback function
	document.addEventListener('DOMContentLoaded', function() {

		//After 3 seconds of first load,
		//Remove the message alert
		setTimeout(function(){
				
			//Get the document element with ID Alert 
			//And add "slideright" class, which will slide the alert up and 
			//finally disappeared
			document.getElementById('alert').classList.add('slideright');

		}, 3000);

		//iF the element wiht logout id is clicked
		document.getElementById('logout').addEventListener('click', function(e) {

			//If clicked then, 
			//a warning modal will appear
			swal({
			  title: "Are you sure you want to log out?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {

			  if (willDelete) {
			  	//Ge the logout form and submit the form if the admin says yes or ok
			  	document.getElementById("logout-form").submit();

			  } 

			});
		});

		//This is to toggle the sidebar in small screen
		document.getElementById("toggle").addEventListener("click", (e) => {
			document.getElementById("sidebar").classList.toggle("toggle")
		})

		//This is tor close the slider in small screen
		document.getElementById("cross").addEventListener("click", (e) => {
			document.getElementById("sidebar").classList.toggle("toggle")
		})


		//Loop all elmeent with .deleteLink class
		document.querySelectorAll(".deleteLink").forEach((deleteLink, index) => {

			//If the link is clicked
			deleteLink.addEventListener("click", (e) => {

				//Prevent the default behaviour 
				e.preventDefault();

				// Show a warning/
				swal({
				  title: "Are you sure you want to delete it?",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {

				  if (willDelete) {

				  	// Grab the hidden form and submit the form
					e.target.parentElement.nextElementSibling.submit();

				  } 

				});

			})
		})



	});
</script>
</body>
</html>
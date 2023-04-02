<?php require  "partials/header.php"; ?>


<div class="h-screen overflow-hidden flex flex-col justify-center items-center bg-gray-300 px-6 py-6">
    <div class="w-full login" >

        <div class="mb-3 flex justify-center items-center">
            <img src="/assets/logo.png">
        </div>

        <?php if($errors['status']): ?>

            <div class="alert alert-danger" id="alert">
                <?php echo $errors['message']; ?>
            </div>



        <?php endif; ?>

        <form method="POST">
            <!-- //if not set action,then will post to same route -->
            <div class="login_wrapper">
                <div class="mb-4 flex flex-col">
                    <label for="email" class="label">Email </label>
                    <input type="text" name="email" 
                        class=" border  px-2 py-2 rounded 
                        "
                        placeholder="admin@gmail.com" required
                        value="<?php echo $_POST['email'] ?? ''; ?>" />
                </div>

                <div class="mb-4 flex flex-col">
                    <label for="password" class="label">Password </label>
                    <input type="password" name="password"  required
                        class=" border  px-2 py-2 rounded "
                        placeholder="**********"
                        value="<?php echo $_POST['password'] ?? ''; ?>" />

                </div>

                <div class="mt-3">
                    <button type="submit" class="px-10 py-2 rounded login_btn text-white">Login </button>
                </div>
            </div>
        </form>

    </div>
</div>

<?php require  "partials/footer.php"; ?>

<?php require  "partials/header.php"; ?>

<div class="w-screen screen bg">

<?php require  "partials/nav.php"; ?>


    <?php if($_SESSION['id'] && $_SESSION['username'] && isset($_SESSION['success'])): ?>

        <div class="alert alert-success" id="alert">
            <?php 
                echo $_SESSION['success'];
                unset($_SESSION['success']);
             ?>
        </div>

    <?php endif; ?>

    <div class="main flex flex-col flex-1 h-full overflow-hidden">
       
        <?php require  "partials/topbar.php"; ?>

        <!-- 
            Main content -->
        <main class="flex-1 ">
        <div class="mb-3 flex breadcrumb">
            <a href="/dashboard" class="breadcrumb-link">Dashboard</a>
            <span class="separator">/</span>
            <span class="breadcrumb-link breadcrumb_active">Change Password</span>
        </div>
            
        <?php if($message): ?>

            <div class="alert alert-danger" id="alert">
                <?php echo $message;  ?>
            </div>



        <?php endif; ?>




        <div class="reset-form">
        <form method="POST">

            <div class="personal">

                <div class="personal_left">
                    <h3 class="title" >Change Password</h3>
                </div>

                <div class="">
                <div class="mb-4 flex flex-col">

                    <label for="old" class="label">Current Password </label>
                    <input type="text" name="old" 
                        class=" border  px-2 py-2 rounded 
                        "
                        placeholder="*********"
                        value="<?php echo $_POST['old'] ?? ''; ?>" />
                </div>

                    <div class="mb-4 flex flex-col">

                    <label for="new" class="label">New Password </label>
                    <input type="text" name="new" 
                        class=" border  px-2 py-2 rounded 
                        "
                                            placeholder="*********"

                        value="<?php echo $_POST['new'] ?? ''; ?>" />
                </div>
                </div>

            </div>

            <div class="mb-3 form_action">
                <div></div>                
                <button type="submit" class="px-10 py-2 rounded login_btn text-white">Save </button>
            </div>
        </form>
    </div>
</main>
</div>
    </div>

</div>

<?php require  "partials/footer.php"; ?>

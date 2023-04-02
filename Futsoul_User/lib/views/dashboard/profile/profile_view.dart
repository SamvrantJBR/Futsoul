import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/dashboard/profile/profile_controller.dart';
import 'package:futsoul_user/views/dashboard/profile/change_password_screen.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/dashboard/profile/edit_profile_screen.dart';
import 'package:futsoul_user/views/favorites_screen.dart';
import 'package:futsoul_user/widget/row/profile_list.dart';
import 'package:get/get.dart';

import 'change_theme_screen.dart';

class ProfileView extends StatelessWidget {
  final c = Get.find<ProfileController>();
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    imageUrl: c.user.value?.image ?? "",
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      ImagePath.imagePlaceholder,
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Text(
                  "${c.user.value?.name}",
                  style: CustomTextStyles.f16W600(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  "+977-${c.user.value?.phone}",
                  style: CustomTextStyles.f14W400(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  "${c.user.value?.email}",
                  style: CustomTextStyles.f14W400(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              ProfileTile(
                onTap: () {
                  Get.toNamed(EditProfileScreen.routeName);
                },
                leadingIcon: Icons.person_2_outlined,
                title: "Edit Profile",
              ),
              ProfileTile(
                onTap: () {
                  Get.toNamed(FavoritesScreen.routeName);
                },
                leadingIcon: Icons.favorite_border,
                title: "Favorites",
              ),
              ProfileTile(
                onTap: () {
                  Get.toNamed(ChangeThemeScreen.routeName);
                },
                leadingIcon: Icons.brightness_6_outlined,
                title: "Theme",
              ),
              ProfileTile(
                onTap: () {
                  Get.toNamed(ChangePasswordScreen.routeName);
                },
                leadingIcon: Icons.lock_outline,
                title: "Change Password",
              ),
              ProfileTile(
                onTap: () {
                  c.coreController.logOut();
                  
                },
                leadingIcon: Icons.logout,
                title: "Log Out",
                showTrailing: false,
                color: AppColors.errorColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

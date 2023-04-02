import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/core_controller.dart';
import 'package:futsoul_user/views/dashboard/profile/change_password_screen.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/dashboard/profile/change_theme_screen.dart';
import 'package:futsoul_user/views/dashboard/profile/edit_profile_screen.dart';
import 'package:futsoul_user/views/favorites_screen.dart';
import 'package:futsoul_user/widget/row/profile_list.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatelessWidget {
  final coreController = Get.find<CoreController>();
  DrawerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context); 
    return Drawer(
      backgroundColor: theme.colorScheme.background,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: CachedNetworkImage(
                  imageUrl: coreController.currentUser.value?.image ?? "",
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
                "${coreController.currentUser.value?.name}",
                style: CustomTextStyles.f16W600(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 1,
                color: Color(0xFFAAAAAA),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ProfileTile(
              onTap: () {
                Get.back();
                Get.toNamed(EditProfileScreen.routeName);
              },
              leadingIcon: Icons.person_2_outlined,
              title: "Edit Profile",
              showTrailing: false,
            ),
            ProfileTile(
              onTap: () {
                Get.back();
                Get.toNamed(FavoritesScreen.routeName);
              },
              leadingIcon: Icons.favorite_border,
              title: "Favorites",
              showTrailing: false,
            ),
            ProfileTile(
              onTap: () {
                Get.back();
                Get.toNamed(ChangeThemeScreen.routeName);
              },
              leadingIcon: Icons.brightness_6_outlined,
              title: "Theme",
              showTrailing: false,
            ),
            ProfileTile(
              onTap: () {
                Get.back();
                Get.toNamed(ChangePasswordScreen.routeName);
              },
              leadingIcon: Icons.lock_outline,
              title: "Change Password",
              showTrailing: false,
            ),
            ProfileTile(
              onTap: () {
                coreController.logOut();
              },
              leadingIcon: Icons.logout,
              title: "Log Out",
              showTrailing: false,
              color: AppColors.errorColor,
            )
          ],
        ),
      ),
    );
  }
}

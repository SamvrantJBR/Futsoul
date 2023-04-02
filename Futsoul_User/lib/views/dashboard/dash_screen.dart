import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/dashboard/dash_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/dashboard/drawer_screen.dart';
import 'package:futsoul_user/widget/custom/custom_bottom_nav_icon.dart';
import 'package:get/get.dart';

class DashScreen extends StatelessWidget {
  static const String routeName = "/dash-screen";
  final c = Get.find<DashController>();
  DashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: c.key,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            c.key.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ),
      drawer: DrawerScreen(),
      body: Obx(() => c.pages[c.currentIndex.value]),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 8,
                spreadRadius: 1,
                color: theme.colorScheme.shadow)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => CustomBottomNavIcon(
                title: "Home",
                imagePath: ImagePath.home,
                isActive: c.currentIndex.value == 0,
                onTap: () {
                  c.currentIndex.value = 0;
                },
              ),
            ),
            Obx(
              () => CustomBottomNavIcon(
                title: "History",
                imagePath: ImagePath.history,
                isActive: c.currentIndex.value == 1,
                onTap: () {
                  c.currentIndex.value = 1;
                },
              ),
            ),
            Obx(
              () => CustomBottomNavIcon(
                title: "Profile",
                imagePath: ImagePath.person,
                isActive: c.currentIndex.value == 2,
                onTap: () {
                  c.currentIndex.value = 2;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}



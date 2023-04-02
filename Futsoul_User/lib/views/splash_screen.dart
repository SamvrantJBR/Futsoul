import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/splash_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash-screen";
  final c = Get.find<SplashController>();
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          ImagePath.logo,
          height: Get.height / 5,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/auth/login_screen.dart';
import 'package:futsoul_user/views/auth/signup_screen.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:futsoul_user/widget/custom/outlined_button.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = "/welcome-screen";
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        margin: const EdgeInsets.symmetric(horizontal: 42),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.logo2,
              height: 75,
            ),
            SvgPicture.asset(
              ImagePath.welcome,
              height: Get.height / 3.5,
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              "Find and book futsal courts with ease. Start playing today!",
              style: CustomTextStyles.f16W600(color: AppColors.primaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 28,
            ),
            CustomElevatedButton(
              title: "Log In",
              onTap: () {
                Get.toNamed(LoginScreen.routeName);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            CustomOutlinedButton(
              title: "Sign Up",
              onTap: () {
                Get.toNamed(SignupScreen.routeName);
              },
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}

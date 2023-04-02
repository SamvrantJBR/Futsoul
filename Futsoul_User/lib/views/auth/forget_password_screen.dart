import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/auth/forget_password_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/utils/validators.dart';
import 'package:futsoul_user/views/auth/login_screen.dart';
import 'package:futsoul_user/widget/custom/custome_textfield.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = "/forget-password";
  final c = Get.find<ForgetPasswordController>();
  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 42),
            height: Get.height - 50,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  ImagePath.logo2,
                  height: 75,
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(
                              1,
                              1,
                            ),
                            blurRadius: 8,
                            spreadRadius: 1,
                            color: theme.colorScheme.shadow)
                      ]),
                  child: Form(
                    key: c.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Forget Password",
                          style: CustomTextStyles.f32W600(),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        CustomTextField(
                            controller: c.emailController,
                            hint: "Email",
                            validator: Validators.checkEmailField,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomElevatedButton(
                          title: "Continue",
                          onTap: c.onSubmit,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextButton(
                    onPressed: () {
                      Get.offNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      "Back To Login",
                      style: CustomTextStyles.f16W400(
                        color: AppColors.primaryColor,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

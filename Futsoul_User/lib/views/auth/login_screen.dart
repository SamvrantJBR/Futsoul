import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/auth/login_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/utils/validators.dart';
import 'package:futsoul_user/views/auth/forget_password_screen.dart';
import 'package:futsoul_user/views/auth/signup_screen.dart';
import 'package:futsoul_user/widget/custom/custom_password_fields.dart';
import 'package:futsoul_user/widget/custom/custome_textfield.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";
  final c = Get.find<LoginController>();
  LoginScreen({super.key});

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      color: theme.colorScheme.background,
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
                          "Login",
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
                        Obx(
                          () => CustomPasswordField(
                              hint: "Password",
                              eye: c.passwordObscure.value,
                              onEyeClick: c.onEyeCLick,
                              controller: c.passwordController,
                              textInputAction: TextInputAction.done),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(ForgetPasswordScreen.routeName);
                          },
                          child: Text(
                            "Forget Password?",
                            style: CustomTextStyles.f16W400(
                                color: AppColors.primaryColor),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomElevatedButton(
                          title: "Log In",
                          onTap: c.onSubmit,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to Futsoul?",
                      style: CustomTextStyles.f16W400(
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.offNamed(SignupScreen.routeName);
                        },
                        child: Text(
                          "Sign Up Now",
                          style: CustomTextStyles.f16W400(
                            color: AppColors.primaryColor,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

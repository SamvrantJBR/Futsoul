import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/auth/reset_password_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/utils/validators.dart';
import 'package:futsoul_user/views/auth/login_screen.dart';
import 'package:futsoul_user/widget/custom/custom_password_fields.dart';
import 'package:futsoul_user/widget/custom/custome_textfield.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "/reset-password";
  final c = Get.find<ResetPasswordController>();
  final String email;
  ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    c.email = email;
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
                          "Set Password",
                          style: CustomTextStyles.f32W600(),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        CustomTextField(
                            controller: c.otpController,
                            hint: "OTP",
                            validator: Validators.checkFieldEmpty,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number),
                        Obx(
                          () => CustomPasswordField(
                              hint: "New Password",
                              eye: c.newPassObscure.value,
                              onEyeClick: c.onEyeCLick,
                              controller: c.newPassController,
                              textInputAction: TextInputAction.done),
                        ),
                        Obx(
                          () => CustomPasswordField(
                              hint: "Confirm Password",
                              eye: c.conPassObscure.value,
                              onEyeClick: c.onconEyeCLick,
                              controller: c.conPassController,
                              validator: (fieldContent) {
                                return Validators.checkConfirmPassword(
                                    c.newPassController.text, fieldContent);
                              },
                              textInputAction: TextInputAction.done),
                        ),
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
                Text(
                  "We’ve sent OTP to your mail",
                  style: CustomTextStyles.f16W400(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code?",
                      style: CustomTextStyles.f16W400(
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Resend OTP",
                          style: CustomTextStyles.f16W400(
                            color: AppColors.primaryColor,
                          ),
                        ))
                  ],
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

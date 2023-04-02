import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/auth/otp_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/auth/login_screen.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
  static const String routeName = "/verify-screen";
  final c = Get.find<OTPController>();
  final String email;
  OTPScreen({super.key, required this.email});

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
                            color: Colors.black.withOpacity(0.1))
                      ]),
                  child: Form(
                    key: c.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter OTP",
                          style: CustomTextStyles.f32W600(),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Pinput(
                          keyboardType: TextInputType.number,
                          length: 6,
                          controller: c.otpCOntroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter OTP";
                            } else if (value.length < 6) {
                              return "Invalid OTP";
                            } else {
                              return null;
                            }
                          },
                          onSubmitted: (value) => c.onSubmit(),
                          defaultPinTheme: PinTheme(
                              height: 56,
                              width: (Get.width - 116) / 6,
                              textStyle: CustomTextStyles.f24W600(),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color:
                                              AppColors.secondaryTextColor)))),
                        ),
                        const SizedBox(
                          height: 20,
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

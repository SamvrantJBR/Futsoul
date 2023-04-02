import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/dashboard/profile/change_password_controller.dart';
import 'package:futsoul_user/utils/validators.dart';
import 'package:futsoul_user/widget/custom/custom_appbar.dart';
import 'package:futsoul_user/widget/custom/custom_password_fields.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = "/change-password";
  final c = Get.find<ChangePasswordController>();
  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Change Password"),
      body: SingleChildScrollView(
        child: Form(
          key: c.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: Get.height/1.2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => CustomPasswordField(
                        hint: "Old Password",
                        labelText: "Old Password",
                        eye: c.oldPassEye.value,
                        onEyeClick: c.onOldEyeClick,
                        controller: c.oldPassCon,
                        textInputAction: TextInputAction.next),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => CustomPasswordField(
                        hint: "New Password",
                        labelText: "New Password",
                        eye: c.newPassEye.value,
                        onEyeClick: c.onNewEyeClick,
                        controller: c.newPassCon,
                        textInputAction: TextInputAction.next),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => CustomPasswordField(
                        hint: "Confirm Password",
                        labelText: "Confirm Password",
                        eye: c.confirmPassEye.value,
                        onEyeClick: c.onConfirmEyeClick,
                        controller: c.confirmPassCon,
                        validator: (fieldContent) {
                          return Validators.checkConfirmPassword(
                              c.newPassCon.text, fieldContent);
                        },
                        textInputAction: TextInputAction.done),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                    title: "Change Password",
                    onTap: c.onSubmit,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

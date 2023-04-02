import 'package:flutter/material.dart';
import 'package:futsoul_user/repo/auth/forget_password_repo.dart';
import 'package:futsoul_user/utils/custom_snackbar.dart';
import 'package:futsoul_user/views/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);
  String? email;

  final newPassController = TextEditingController();
  final conPassController = TextEditingController();
  final otpController = TextEditingController();

  RxBool newPassObscure = true.obs;
  RxBool conPassObscure = true.obs;

  void onEyeCLick() {
    newPassObscure.value = !newPassObscure.value;
  }

  void onconEyeCLick() {
    conPassObscure.value = !conPassObscure.value;
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "PLease wiat ..");
      await ForgetPasswordRepo.resetPassword(
        email: email!,
        otp: otpController.text,
        password: newPassController.text,
        onSuccess: (message) async {
          loading.hide();
          Get.offAllNamed(WelcomeScreen.routeName);
          CustomSnackBar.success(title: "Reset Password", message: message);
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Reset Password", message: message);
        },
      );
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/core_controller.dart';
import 'package:futsoul_user/repo/auth/login_repo.dart';
import 'package:futsoul_user/utils/custom_snackbar.dart';
import 'package:futsoul_user/views/dashboard/dash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../utils/storage_keys.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool passwordObscure = true.obs;

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "PLease wiat ..");
      await LoginRepo.login(
        email: emailController.text,
        password: passwordController.text,
        onSuccess: (user, token) async {
          loading.hide();
          final box = GetStorage();
          await box.write(
              StorageKeys.ACCESS_TOKEN, json.encode(token.toJson()));
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          Get.find<CoreController>().loadCurrentUser();
          Get.offAllNamed(DashScreen.routeName);
          CustomSnackBar.success(title: "Login", message: "Login Successfull");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Login", message: message);
        },
      );
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/core_controller.dart';
import 'package:futsoul_merchant/repo/auth/register_repo.dart';
import 'package:futsoul_merchant/utils/custom_snackbar.dart';
import 'package:futsoul_merchant/utils/storage_keys.dart';
import 'package:futsoul_merchant/views/auth/complete_profile_screen.dart';
import 'package:futsoul_merchant/views/dashboard/dash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool passwordObscure = true.obs;

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "PLease wiat ..");
      await RegisterRepo.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        onSuccess: (user, token) async {
          loading.hide();
          final box = GetStorage();
          await box.write(
              StorageKeys.ACCESS_TOKEN, json.encode(token.toJson()));
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          Get.find<CoreController>().loadCurrentUser();
          Get.offAllNamed(CompleteProfileScreen.routeName);
          CustomSnackBar.success(
              title: "Sign up", message: "User registered succesfully");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Sign up", message: message);
        },
      );
    }
  }
}

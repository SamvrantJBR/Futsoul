import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:futsoul_user/views/auth/reset_password_screen.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String? email;

  final otpCOntroller = TextEditingController();

  void onSubmit() async {
    log("$email =================>");
    if (formKey.currentState!.validate()) {
      Get.offNamed(ResetPasswordScreen.routeName,
          arguments: [email, otpCOntroller.text]);
    }
  }
}

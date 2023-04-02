import 'package:flutter/material.dart';
import 'package:futsoul_user/repo/profile/change_password_repo.dart';
import 'package:futsoul_user/utils/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ChangePasswordController extends GetxController{

  final formKey = GlobalKey<FormState>();
  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  final oldPassCon = TextEditingController();
  final newPassCon = TextEditingController();
  final confirmPassCon = TextEditingController();

  FocusNode oldPassNode = FocusNode();
  FocusNode newPassNode = FocusNode();
  FocusNode confirmPassNode = FocusNode();

  RxBool oldPassEye = RxBool(true);
  RxBool newPassEye = RxBool(true);
  RxBool confirmPassEye = RxBool(true);

  void onOldEyeClick() {
    oldPassEye.value = !oldPassEye.value;
  }

  void onNewEyeClick() {
    newPassEye.value = !newPassEye.value;
  }

  void onConfirmEyeClick() {
    confirmPassEye.value = !confirmPassEye.value;
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "Please wiat..");
      await ChangePasswordRepo.changePassword(
          oldPassword: oldPassCon.text,
          newPassword: newPassCon.text,
          onSuccess: (message) {
            loading.hide();
            Get.back();
            CustomSnackBar.success(title: "Change Password", message: message);
          },
          onError: (message) {
            loading.hide();
            CustomSnackBar.error(title: "Change Password", message: message);
          });
    }
  }

}
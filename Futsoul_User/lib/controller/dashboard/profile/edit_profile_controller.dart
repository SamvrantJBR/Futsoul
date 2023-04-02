import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/core_controller.dart';
import 'package:futsoul_user/controller/dashboard/profile/profile_controller.dart';
import 'package:futsoul_user/models/user.dart';
import 'package:futsoul_user/repo/profile/update_profile.dart';
import 'package:futsoul_user/utils/custom_snackbar.dart';
import 'package:futsoul_user/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final coreController = Get.find<CoreController>();
  final profileController = Get.find<ProfileController>();

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);
  final picker = ImagePicker();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Rxn<User> user = Rxn<User>();
  Rxn<File> image = Rxn<File>();

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  void loadUser() {
    user.value = profileController.user.value;
    nameController.text = user.value!.name!;
    phoneController.text = user.value!.phone!;
    emailController.text = user.value!.email!;
  }

  void pickImage() async {
    log("Picking image");
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 500,
        maxWidth: 500);

    if (pickedImage != null) {
      image.value = File(pickedImage.path);
    }
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "Please wait ..");

      await UpdateProfileRepo.updateProfile(
        image: image.value,
        name: nameController.text,
        phone: phoneController.text,
        onSuccess: (user, message) async {
          loading.hide();
          final box = GetStorage();
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          coreController.loadCurrentUser();
          profileController.loadUser();
          Get.back();
          CustomSnackBar.success(title: "Update Profile", message: message);
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Update Profile", message: message);
        },
      );
    }
  }
}

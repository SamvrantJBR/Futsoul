import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/core_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/profile_controller.dart';
import 'package:futsoul_merchant/models/user.dart';
import 'package:futsoul_merchant/repo/profile/update_profile_repo.dart';
import 'package:futsoul_merchant/utils/custom_snackbar.dart';
import 'package:futsoul_merchant/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final coreController = Get.find<CoreController>();
  final profileController = Get.find<ProfileController>();

  Rxn<User> user = Rxn<User>();
  Rxn<File> image = Rxn<File>();
  Rxn<File> bannerImage = Rxn<File>();
  RxBool imageError = RxBool(false);
  RxBool bannerImageError = RxBool(false);

  final nameController = TextEditingController();
  final futsalNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final priceController = TextEditingController();
  final openTimeController = TextEditingController();
  final closeTimeController = TextEditingController();

  final picker = ImagePicker();

  Rxn<TimeOfDay> openingTime = Rxn<TimeOfDay>();
  Rxn<TimeOfDay> closingTime = Rxn<TimeOfDay>();
  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );

  @override
  void onInit() {
    loadUser();
    super.onInit();
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

  void pickBannerImage() async {
    log("Picking image");
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 500,
        maxWidth: 500);

    if (pickedImage != null) {
      bannerImage.value = File(pickedImage.path);
    }
  }

  void loadUser() {
    user.value = Get.find<CoreController>().currentUser.value;
    nameController.text = user.value?.name ?? "";
    futsalNameController.text = user.value?.futsalName ?? "";
    phoneController.text = user.value?.phone ?? "";
    addressController.text = user.value?.location ?? "";
    priceController.text = user.value?.price ?? "";
    var openTime = TimeOfDay(
        hour: int.parse(user.value!.startTime!.split(":")[0]),
        minute: int.parse(user.value!.startTime!.split(":")[1]));
    var closeTime = TimeOfDay(
        hour: int.parse(user.value!.endTime!.split(":")[0]),
        minute: int.parse(user.value!.endTime!.split(":")[1]));
    openTimeController.text = openTime.format(Get.context!);
    closeTimeController.text = closeTime.format(Get.context!);
  }

  void updateProfile() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "Please wait ..");

      await UpdateProfileRepo.updateProfile(
        image: image.value,
        bannerImage: bannerImage.value,
        address: addressController.text,
        price: priceController.text,
        name: nameController.text,
        futsalName: futsalNameController.text,
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

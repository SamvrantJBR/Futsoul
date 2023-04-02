import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/core_controller.dart';
import 'package:futsoul_merchant/repo/auth/complete_profile_repo.dart';
import 'package:futsoul_merchant/utils/custom_snackbar.dart';
import 'package:futsoul_merchant/utils/extension.dart';
import 'package:futsoul_merchant/views/dashboard/dash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../utils/storage_keys.dart';

class CompleteProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rxn<File> image = Rxn<File>();
  Rxn<File> bannerImage = Rxn<File>();
  RxBool imageError = RxBool(false);
  RxBool bannerImageError = RxBool(false);

  final nameController = TextEditingController();
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

  void pickOpeningTime(
      {TimePickerEntryMode entryMode = TimePickerEntryMode.dial}) async {
    TimePickerEntryMode mode = entryMode;
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialEntryMode: entryMode,
      onEntryModeChanged: (entryMode) {
        mode = entryMode;
      },
      initialTime: openingTime.value ?? TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    if (closingTime.value != null &&
        pickedTime.compareTo(closingTime.value!) > -1) {
      CustomSnackBar.error(
          title: "Opening Time",
          message: "Opening time cannot be greater than closing time");
      pickOpeningTime(entryMode: mode);
    } else {
      openingTime.value = pickedTime;
      openTimeController.text = pickedTime.format(Get.context!);
    }
  }

  void pickClosingTime(
      {TimePickerEntryMode entryMode = TimePickerEntryMode.dial}) async {
    TimePickerEntryMode mode = entryMode;
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialEntryMode: entryMode,
      onEntryModeChanged: (entryMode) {
        mode = entryMode;
      },
      initialTime: closingTime.value ?? TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    if (openingTime.value != null &&
        pickedTime.compareTo(openingTime.value!) < 1) {
      CustomSnackBar.error(
          title: "Closing Time",
          message: "Closing time cannot be less than closing time");
      pickClosingTime(entryMode: mode);
    } else {
      closingTime.value = pickedTime;
      closeTimeController.text = pickedTime.format(Get.context!);
    }
  }

  void submit() async {
    imageError.value = image.value == null;
    bannerImageError.value = bannerImage.value == null;
    if (formKey.currentState!.validate()) {
      if (imageError.value || bannerImageError.value) return;

      loading.show(message: "Please wait ..");

      await CompleteProfileRepo.completeProfile(
        image: image.value!,
        bannerImage: bannerImage.value!,
        address: addressController.text,
        endTime: "${closingTime.value!.hour}:${closingTime.value!.minute}",
        startTime: "${openingTime.value!.hour}:${openingTime.value!.minute}",
        price: priceController.text,
        name: nameController.text,
        phone: phoneController.text,
        onSuccess: (user, message) async {
          loading.hide();
          final box = GetStorage();
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          Get.find<CoreController>().loadCurrentUser();
          Get.offAllNamed(DashScreen.routeName);
          CustomSnackBar.success(title: "Login", message: "Login Successfull");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Update Profile", message: message);
        },
      );
    }
  }
}

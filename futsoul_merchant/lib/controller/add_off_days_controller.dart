import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/off_days_controller.dart';
import 'package:futsoul_merchant/repo/off_days_repo.dart';
import 'package:futsoul_merchant/utils/custom_snackbar.dart';
import 'package:futsoul_merchant/utils/extension.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddOffDaysController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  Rxn<DateTime> startDate = Rxn<DateTime>();
  Rxn<DateTime> endDate = Rxn<DateTime>();
  Rxn<TimeOfDay> startTime = Rxn<TimeOfDay>();
  Rxn<TimeOfDay> endTime = Rxn<TimeOfDay>();

  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );

  void pickStartDate() async {
    DatePicker.showDatePicker(
      Get.context!,
      showTitleActions: true,
      minTime: DateTime.now().add(const Duration(days: 3)),
      onChanged: (date) {},
      onConfirm: (date) {
        startDateController.text = date.toString().split(" ")[0];
        startDate.value = date;
      },
      currentTime:
          startDate.value ?? DateTime.now().add(const Duration(days: 3)),
      locale: LocaleType.en,
    );
  }

  void pickEndDate() async {
    DatePicker.showDatePicker(
      Get.context!,
      showTitleActions: true,
      minTime: DateTime.now().add(const Duration(days: 3)),
      onChanged: (date) {},
      onConfirm: (date) {
        endDateController.text = date.toString().split(" ")[0];
        endDate.value = date;
      },
      currentTime: endDate.value ?? DateTime.now().add(const Duration(days: 3)),
      locale: LocaleType.en,
    );
  }

  void pickStartTime(
      {TimePickerEntryMode entryMode = TimePickerEntryMode.dial}) async {
    TimePickerEntryMode mode = entryMode;
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialEntryMode: entryMode,
      onEntryModeChanged: (entryMode) {
        mode = entryMode;
      },
      initialTime: startTime.value ?? TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    if (endTime.value != null && pickedTime.compareTo(endTime.value!) > -1) {
      CustomSnackBar.error(
          title: "Start Time",
          message: "Start time cannot be greater than end time");
      pickStartTime(entryMode: mode);
    } else {
      startTime.value = pickedTime;
      startTimeController.text = pickedTime.format(Get.context!);
    }
  }

  void pickEndTime(
      {TimePickerEntryMode entryMode = TimePickerEntryMode.dial}) async {
    TimePickerEntryMode mode = entryMode;
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialEntryMode: entryMode,
      onEntryModeChanged: (entryMode) {
        mode = entryMode;
      },
      initialTime: endTime.value ?? TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    if (startTime.value != null && pickedTime.compareTo(startTime.value!) < 1) {
      CustomSnackBar.error(
          title: "End Time",
          message: "End time cannot be less than closing time");
      pickEndTime(entryMode: mode);
    } else {
      endTime.value = pickedTime;
      endTimeController.text = pickedTime.format(Get.context!);
    }
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      if (startTime.value != null && endTime.value == null) {
        CustomSnackBar.info(message: "Please select End time");
        return;
      }

      if (startTime.value == null && endTime.value != null) {
        CustomSnackBar.info(message: "Please select Start time");
        return;
      }

      loading.show(message: "Please wait ..");

      await OffDyasRepo.addOffDays(
        startDate: startDateController.text,
        endDate: endDateController.text,
        startTime: startTime.value?.format(Get.context!),
        endTime: endTime.value?.format(Get.context!),
        onSuccess: (message) {
          Get.back();
          CustomSnackBar.success(title: "Off Days", message: message);
          Get.find<OffDaysController>().getOffDays();
          loading.hide();
        },
        onError: (message) {
          CustomSnackBar.error(title: "Off Day", message: message);
          loading.hide();
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/core_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/history_controller.dart';
import 'package:futsoul_merchant/models/time_slot.dart';
import 'package:futsoul_merchant/models/user.dart';
import 'package:futsoul_merchant/repo/booking/booking_repo.dart';
import 'package:futsoul_merchant/repo/general/futsal_repo.dart';
import 'package:futsoul_merchant/utils/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class BookingController extends GetxController {

   final formKey = GlobalKey<FormState>();
  Rxn<User> futsal = Rxn<User>();
  RxBool isLoading = RxBool(false);

  RxMap<String, List<TimeSlot>> timeSlots = RxMap<String, List<TimeSlot>>();
  Rxn<TimeSlot> selectedTimeSlot = Rxn<TimeSlot>();

  RxString selectedDateTime = RxString("");
  RxList<DateTime> availableDates = RxList([]);
  RxList<String> dateKeys = RxList<String>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  @override
  void onInit() {
    getFutsalDetails();
    super.onInit();
  }

  void getFutsalDetails() async {
    isLoading.value = true;
    await FutsalRepo.getFutsalDetails(
      id: Get.find<CoreController>().currentUser.value!.id!,
      onSuccess: (futsal, slots) {
        isLoading.value = false;
        this.futsal.value = futsal;
        timeSlots.addAll(slots);
        getAvailableDates();
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }

  void getAvailableDates() {
    var keys = timeSlots.keys;
    dateKeys.addAll(keys);
    for (var key in keys) {
      var date = DateTime.parse(key);
      availableDates.add(date);
    }
    selectedDateTime.value = dateKeys[0];
  }

  void selectDate(String selectedKey) {
    selectedDateTime.value = selectedKey;
    selectedTimeSlot.value = null;
  }

  void selectTimeSlot(TimeSlot timeSlot) {
    selectedTimeSlot.value = timeSlot;
  }

  void bookFutsal() async {
    if(formKey.currentState!.validate()){
      loading.show(message: "Please wait ..");

    await BookingRepo.newBookig(
      fullName: nameController.text,
      phone: phoneController.text,
      date: selectedTimeSlot.value!.date!,
      startTime: selectedTimeSlot.value!.start!,
      endTime: selectedTimeSlot.value!.end!,
      onSuccess: (booking) {
        Get.find<HistoryController>().getActiveBooking();
        Get.find<HistoryController>().getPastBooking();
        loading.hide();
        Get.back();

        CustomSnackBar.success(title: "Booking", message: "Booking successful");
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Booking", message: message);

      },
    );
    }
  }
}

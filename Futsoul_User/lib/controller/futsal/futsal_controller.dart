import 'dart:developer';

import 'package:futsoul_user/controller/dashboard/history_controller.dart';
import 'package:futsoul_user/controller/dashboard/home_controller.dart';
import 'package:futsoul_user/models/booking.dart';
import 'package:futsoul_user/models/futsals.dart';
import 'package:futsoul_user/models/time_slot.dart';
import 'package:futsoul_user/repo/booking/booking.dart';
import 'package:futsoul_user/repo/general/favorite_repo.dart';
import 'package:futsoul_user/repo/general/futsals_repo.dart';
import 'package:futsoul_user/utils/custom_snackbar.dart';
import 'package:futsoul_user/views/futsal/payment_screen.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class FutsalController extends GetxController {
  Rxn<Futsal> futsal = Rxn<Futsal>();
  Rxn<Booking> booking = Rxn<Booking>();

  RxBool canBook = RxBool(false);

  RxMap<String, List<TimeSlot>> timeSlots = RxMap<String, List<TimeSlot>>();
  Rxn<TimeSlot> selectedTimeSlot = Rxn<TimeSlot>();
  RxBool isLoading = RxBool(false);
  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  RxString selectedDateTime = RxString("");
  RxList<DateTime> availableDates = RxList([]);
  RxList<String> dateKeys = RxList<String>();

  RxBool isFavorite = RxBool(false);
  RxBool isLoadingFav = RxBool(false);

  @override
  void onInit() {
    var data = Get.arguments;
    futsal.value = data[0];
    getFutsalDetails();
    checkIsFavorite();
    super.onInit();
  }

  void canMakeBooking(){
    if(isLoading.value){
      canBook.value = false;
      return;
    }

    if(!(futsal.value?.isAvailable??true)){
      canBook.value = false;
    }

    if(timeSlots.isEmpty){
      canBook.value = false;
      return;
    }

    canBook.value = true;
  }

  void getFutsalDetails() async {
    isLoading.value = true;
    canMakeBooking();
    await FutsalRepo.getFutsalDetails(
      id: futsal.value!.id!,
      onSuccess: (futsal, slots) {
        isLoading.value = false;
        this.futsal.value = futsal;
        timeSlots.addAll(slots);
        getAvailableDates();
        
      },
      onError: (message) {
        isLoading.value = false;
        canMakeBooking();
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
    canMakeBooking();
  }

  void saveFavorite() async {
    isLoadingFav.value = true;
    await FavoriteRepo.toogleFavorite(
      id: futsal.value!.id!,
      onSuccess: (isFav) {
        isLoadingFav.value = false;
        isFavorite.value = isFav;
        Get.find<HomeController>().loadFavorites();
      },
      onError: (message) {
        isLoadingFav.value = false;
      },
    );
  }

  void checkIsFavorite() async {
    isLoadingFav.value = true;
    await FavoriteRepo.isFavorite(
      id: futsal.value!.id!,
      onSuccess: (isFav) {
        isLoadingFav.value = false;
        isFavorite.value = isFav;
      },
      onError: (message) {
        isLoadingFav.value = false;
      },
    );
  }

  void selectDate(String selectedKey) {
    selectedDateTime.value = selectedKey;
    selectedTimeSlot.value = null;
  }

  void selectTimeSlot(TimeSlot timeSlot) {
    selectedTimeSlot.value = timeSlot;
  }

  void bookFutsal() async {
    loading.show(message: "Please wait ..");

    await BookingRepo.newBookig(
      merchantId: futsal.value!.id!,
      date: selectedTimeSlot.value!.date!,
      startTime: selectedTimeSlot.value!.start!,
      endTime: selectedTimeSlot.value!.end!,
      onSuccess: (booking) {
        this.booking.value = booking;
        Get.find<HistoryController>().getBookings();
        loading.hide();
        Get.toNamed(PaymentScreen.routeName, arguments: [booking]);
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Booking", message: message);
      },
    );
  }
}

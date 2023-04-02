import 'package:futsoul_merchant/controller/dashboard/history_controller.dart';
import 'package:futsoul_merchant/models/booking.dart';
import 'package:futsoul_merchant/repo/booking/booking_repo.dart';
import 'package:futsoul_merchant/utils/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class BookingDetailsController extends GetxController {
  Rxn<Booking> booking = Rxn<Booking>();

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  @override
  void onInit() {
    var data = Get.arguments;
    booking.value = data[0];
    super.onInit();
  }

  void completeBooking() async {
    loading.show(message: "Please wait");

    await BookingRepo.complete(
      transactionId: booking.value?.transactionId??"",
      onSuccess: (message) {
        loading.hide();
        Get.back();
        CustomSnackBar.success(title: "Booking #${booking.value?.transactionId}", message: message);
        Get.find<HistoryController>().getActiveBooking();
        Get.find<HistoryController>().getPastBooking();
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Booking", message: message);
      },
    );
  }

  void cancelBooking() async {
    loading.show(message: "Please wait");

    await BookingRepo.cancel(
      transactionId: booking.value?.transactionId??"",
      onSuccess: (message) {
        loading.hide();
        Get.back();
        CustomSnackBar.success(title: "Booking #${booking.value?.transactionId}", message: message);
        Get.find<HistoryController>().getActiveBooking();
        Get.find<HistoryController>().getPastBooking();
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Booking", message: message);
      },
    );
  }

}

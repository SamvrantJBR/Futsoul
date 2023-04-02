import 'package:futsoul_user/controller/dashboard/history_controller.dart';
import 'package:futsoul_user/models/booking.dart';
import 'package:futsoul_user/repo/booking/booking.dart';
import 'package:futsoul_user/utils/custom_snackbar.dart';
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

  void cancelBooking() async {
    loading.show(message: "Please wait");

    await BookingRepo.cancelBooking(
      transactionId: booking.value?.transactionId??"",
      onSuccess: (message) {
        loading.hide();
        Get.back();
        CustomSnackBar.success(title: "Booking #${booking.value?.transactionId}", message: message);
        Get.find<HistoryController>().getBookings();
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Booking", message: message);
      },
    );
  }
}

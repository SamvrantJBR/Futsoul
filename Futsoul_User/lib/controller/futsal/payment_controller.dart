import 'dart:developer';

import 'package:futsoul_user/controller/dashboard/history_controller.dart';
import 'package:futsoul_user/models/booking.dart';
import 'package:futsoul_user/repo/payment_repo.dart';
import 'package:futsoul_user/utils/custom_snackbar.dart';
import 'package:futsoul_user/views/booking_details_screen.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class PaymentController extends GetxController {
  Rxn<Booking> booking = Rxn<Booking>();
  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  @override
  void onInit() {
    var data = Get.arguments;
    booking.value = data[0];
    super.onInit();
  }

  void preceedPayment() {
    try {
      final config = PaymentConfig(
        // amount: int.parse(booking.value!.price!),
        amount: 1000,
        productIdentity: booking.value!.transactionId!,
        productName: "Book Futsal",
      );

      KhaltiScope.of(Get.context!).pay(
        config: config,
        preferences: [PaymentPreference.khalti],
        onSuccess: verifyKhaltiTransaction,
        onFailure: (value) {
          log("Khalti Fail =======>");
          log(value.message);
          log("Data ======>");
          log(value.data.toString());
        },
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      CustomSnackBar.error(
          title: "Khalti", message: "Sorry something went wrong");
    }
  }

  void verifyKhaltiTransaction(PaymentSuccessModel result) async {
    loading.show(message: "Please wait ..");

    await PaymentRepo.verifyKhaltiPayment(
      transactionId: booking.value!.transactionId!,
      pidx: result.idx,
      amount: "10",
      token: result.token,
      onSuccess: (booking) {
        loading.hide();
        Get.toNamed(BookingDetailScreen.routeName, arguments: [booking]);
        CustomSnackBar.success();
        Get.find<HistoryController>().getBookings();
      },
      onError: (message) {
        loading.hide();
      },
    );
  }
}

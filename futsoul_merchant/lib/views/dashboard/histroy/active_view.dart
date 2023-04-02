import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/dashboard/history_controller.dart';
import 'package:futsoul_merchant/widget/error_screen.dart';
import 'package:futsoul_merchant/widget/row/booking_list.dart';
import 'package:get/get.dart';

class ActiveBookingView extends StatelessWidget {
  final c = Get.find<HistoryController>();
  ActiveBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.isLoadingActive.value) {
        return SizedBox(
          height: Get.height / 2,
          child: const Center(
            child: LinearProgressIndicator(),
          ),
        );
      } else if (!c.isLoadingActive.value && c.activeBooking.isEmpty) {
        return const ErrorScreen();
      } else {
        return ListView.builder(
          key: const PageStorageKey("active"),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          controller: c.activeScrollController,
          shrinkWrap: true,
          itemCount: c.activeNextPage.value == null
              ? c.activeBooking.length
              : c.activeBooking.length + 1,
          itemBuilder: (context, index) {
            if (index == c.activeBooking.length &&
                c.activeNextPage.value == null) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: (c.activeNextPage.value != null)
                      ? const LinearProgressIndicator()
                      : null);
            }
            var booking = c.activeBooking[index];
            return BookingList(booking: booking);
          },
        );
      }
    });
  }
}

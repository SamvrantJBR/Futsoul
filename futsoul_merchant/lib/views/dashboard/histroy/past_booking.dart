import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/dashboard/history_controller.dart';
import 'package:futsoul_merchant/widget/error_screen.dart';
import 'package:futsoul_merchant/widget/row/booking_list.dart';
import 'package:get/get.dart';

class PastBookingView extends StatelessWidget {
  final c = Get.find<HistoryController>();
  PastBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.isLoadingPast.value) {
        return SizedBox(
          height: Get.height / 2,
          child: const Center(
            child: LinearProgressIndicator(),
          ),
        );
      } else if (!c.isLoadingPast.value && c.pastBooking.isEmpty) {
        return const ErrorScreen();
      } else {
        return ListView.builder(
          key: const PageStorageKey("past"),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          controller: c.pastScrollController,
          shrinkWrap: true,
          itemCount: c.pastNextPage.value == null
              ? c.pastBooking.length
              : c.pastBooking.length + 1,
          itemBuilder: (context, index) {
            if (index == c.pastBooking.length &&
                c.pastNextPage.value == null) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: (c.pastNextPage.value != null)
                      ? const LinearProgressIndicator()
                      : null);
            }
            var booking = c.pastBooking[index];
            return BookingList(booking: booking);
          },
        );
      }
    });
  }
}

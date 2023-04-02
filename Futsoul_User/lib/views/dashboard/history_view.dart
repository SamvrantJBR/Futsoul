import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/dashboard/history_controller.dart';
import 'package:futsoul_user/widget/error_screen.dart';
import 'package:futsoul_user/widget/row/booking_list.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  final c = Get.find<HistoryController>();
  HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            if (c.isLoading.value) {
              return const LinearProgressIndicator();
            } else if (!c.isLoading.value && c.bookings.isEmpty) {
              return const ErrorScreen();
            } else {
              return ListView.builder(
                controller: c.scrollController,
                padding: const EdgeInsets.all(20),
                itemCount: c.nextPage.value != null
                    ? c.bookings.length + 1
                    : c.bookings.length,
                itemBuilder: (context, index) {
                  if (index == c.bookings.length) {
                    return const LinearProgressIndicator();
                  }
                  var booking = c.bookings[index];
                  return BookingList(
                    booking: booking,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

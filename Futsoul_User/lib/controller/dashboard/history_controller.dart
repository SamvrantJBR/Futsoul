import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:futsoul_user/models/booking.dart';
import 'package:futsoul_user/repo/booking/booking.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  RxList<Booking> bookings = RxList<Booking>();
  RxBool isLoading = RxBool(false);
  RxnInt nextPage = RxnInt();

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    scrollListner();
    getBookings();
    super.onInit();
  }

  void scrollListner() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        log("Scroll end reACHED =================>");
        if (nextPage.value != null) getMoreBookings();
      }
    });
  }

  void getBookings() async {
    isLoading.value = true;
    bookings.clear();
    await BookingRepo.getBookings(
      onSuccess: (bookings, nextPage) {
        isLoading.value = false;
        this.bookings.addAll(bookings);
        this.nextPage.value = nextPage;
        log("Next Page ============>${nextPage}");
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }

  void getMoreBookings() async {
    await BookingRepo.getBookings(
      currentPage: nextPage.value,
      onSuccess: (bookings, nextPage) {
        this.bookings.addAll(bookings);
        this.nextPage.value = nextPage;
        log("Next Page ============>${nextPage}");
      },
      onError: (message) {},
    );
  }
}

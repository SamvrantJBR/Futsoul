import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:futsoul_merchant/models/booking.dart';
import 'package:futsoul_merchant/repo/booking/booking_repo.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {

  PageController pageController = PageController(keepPage: true);
  RxString selectedTab = RxString("active");
  Rx<PageStorageKey> pageKey = Rx<PageStorageKey>(const PageStorageKey("Orders"));

  RxList<Booking> activeBooking = RxList<Booking>();
  RxList<Booking> pastBooking = RxList<Booking>();
  
  RxnInt activeNextPage = RxnInt();
  RxnInt pastNextPage = RxnInt();

  RxBool isLoadingActive = RxBool(false);
  RxBool isLoadingPast = RxBool(false);

  final ScrollController activeScrollController = ScrollController();
  final ScrollController pastScrollController = ScrollController();


  void onInit() {
    getActiveBooking();
    getPastBooking();
    scrollListner();
    super.onInit();
  }

  void scrollListner() {
    activeScrollController.addListener(() {
      if (activeScrollController.position.maxScrollExtent ==
          activeScrollController.position.pixels) {
        log("Scroll end reached");
        if (activeNextPage.value != null) getMoreActiveBooking();
      }
    });

    pastScrollController.addListener(() {
      if (pastScrollController.position.maxScrollExtent ==
          pastScrollController.position.pixels) {
        if (pastNextPage.value != null) getMorePastBooking();
      }
    });
  }

  void changeTab(String tab) {
    if (tab == selectedTab.value) return;
    selectedTab.value = tab;
    if (selectedTab.value == "active") {
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    } else {
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }
  
  void getMoreActiveBooking() async{
    await BookingRepo.getActiveBookings(
      currentPage: activeNextPage.value,
      onSuccess: (bookings, nextPage) {
        activeBooking.addAll(bookings);
      },
      onError: (message) {
      },
    );
  }
  
  void getMorePastBooking() async{
    await BookingRepo.getPastBookings(
      currentPage: pastNextPage.value,
      onSuccess: (bookings, nextPage) {
        pastBooking.addAll(bookings);
      },
      onError: (message) {
      },
    );
  }
  
  void getActiveBooking()  async{
    isLoadingActive.value = true;
    activeBooking.clear();
    await BookingRepo.getActiveBookings(
      onSuccess: (bookings, nextPage) {
        activeBooking.addAll(bookings);
        isLoadingActive.value = false;
      },
      onError: (message) {
        isLoadingActive.value = false;
      },
    );

  }
  
  void getPastBooking() async{
    isLoadingPast.value = true;
    pastBooking.clear();
    await BookingRepo.getPastBookings(
      onSuccess: (bookings, nextPage) {
        pastBooking.addAll(bookings);
        isLoadingPast.value = false;
      },
      onError: (message) {
        isLoadingPast.value = false;
      },
    );
  }

}

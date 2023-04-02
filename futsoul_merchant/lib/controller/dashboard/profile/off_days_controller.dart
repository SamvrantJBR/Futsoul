import 'package:flutter/material.dart';
import 'package:futsoul_merchant/models/off_day.dart';
import 'package:futsoul_merchant/repo/off_days_repo.dart';
import 'package:get/get.dart';

class OffDaysController extends GetxController{

  RxList<OffDay> offDays = RxList<OffDay>();
  RxnInt nextPage = RxnInt();
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    getOffDays();
    super.onInit();
  }


  void scrollListner() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (nextPage.value != null) getMoreOffDays();
      }
    });

  }

  void getOffDays()  async{
    isLoading.value = true;
    offDays.clear();
    await OffDyasRepo.getOffDays(
      onSuccess: (offDays, nextPage) {
        this.offDays.addAll(offDays);
        isLoading.value = false;
      },
      onError: (message) {
        isLoading.value = false;
      },
    );

  }
  
  void getMoreOffDays() async{
    await OffDyasRepo.getOffDays(
      onSuccess: (offDays, nextPage) {
        this.offDays.addAll(offDays);
      },
      onError: (message) {
      },
    );
  }

}
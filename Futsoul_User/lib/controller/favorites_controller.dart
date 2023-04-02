import 'package:flutter/material.dart';
import 'package:futsoul_user/repo/general/favorite_repo.dart';
import 'package:get/state_manager.dart';

import '../models/futsals.dart';

class FavoriteController extends GetxController{

  RxList<Futsal> futsals = RxList<Futsal>();
  RxBool isLoading = RxBool(false);
  RxnInt nextPage = RxnInt();

  final ScrollController scrollController = ScrollController();


  

  @override
  void onInit() {
    scrollListner();
    getFavorites();
    super.onInit();
  }

  void scrollListner() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (nextPage.value != null) getMoreBookings();
      }
    });
  }

  void getFavorites() async {
    isLoading.value = true;
    futsals.clear();
    await FavoriteRepo.getFavorites(
      onSuccess: (favorites, nextPage) {
        isLoading.value = false;
        this.futsals.addAll(favorites);
        this.nextPage.value = nextPage;
      },
      onError: (message) {},
    );
  }

  void getMoreBookings() async {
    await FavoriteRepo.getFavorites(
      currentPage: nextPage.value,
      onSuccess: (favorites, nextPage) {
        this.futsals.addAll(favorites);
        this.nextPage.value = nextPage;
      },
      onError: (message) {},
    );
  }

}
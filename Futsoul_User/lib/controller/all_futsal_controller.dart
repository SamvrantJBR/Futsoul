import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_user/repo/general/favorite_repo.dart';
import 'package:futsoul_user/repo/general/futsals_repo.dart';
import 'package:get/state_manager.dart';

import '../models/futsals.dart';

class AllFutsalController extends GetxController {
  RxList<Futsal> futsals = RxList<Futsal>();
  RxBool isLoading = RxBool(false);
  RxnInt nextPage = RxnInt();

  final ScrollController scrollController = ScrollController();

  final searchController = TextEditingController();

  @override
  void onInit() {
    scrollListner();
    getFutsals();
    super.onInit();
  }

  void scrollListner() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
            log("Scroll end reached");
        if (nextPage.value != null) getMoreFutsals();
      }
    });
  }

  void getFutsals() async {
    isLoading.value = true;
    futsals.clear();
    await FutsalRepo.getFutsals(
      onSuccess: (futsals, nextPage) {
        isLoading.value = false;
        this.futsals.addAll(futsals);
        this.nextPage.value = nextPage;
      },
      onError: (message) {},
    );
  }

  void getMoreFutsals() async {
    await FutsalRepo.getFutsals(
      currentPage: nextPage.value,
      onSuccess: (futsals, nextPage) {
        this.futsals.addAll(futsals);
        this.nextPage.value = nextPage;
      },
      onError: (message) {},
    );
  }

  void searchFutsal() async {
    EasyDebounce.debounce("search-futsal", const Duration(seconds: 1),
        () async {
      if (searchController.text.isEmpty) {
        getFutsals();
      } else {
        isLoading.value = true;
        futsals.clear();
        await FutsalRepo.searchFutsals(
          query: searchController.text,
          onSuccess: (futsals) {
            this.futsals.addAll(futsals);
            isLoading.value = false;
            nextPage.value = null;
          },
          onError: (message) {
            isLoading.value = false;
          },
        );
      }
    });
  }
}

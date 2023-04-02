import 'package:flutter/material.dart';
import 'package:futsoul_merchant/views/dashboard/histroy/history_view.dart';
import 'package:futsoul_merchant/views/dashboard/home_view.dart';
import 'package:futsoul_merchant/views/dashboard/profile/profile_view.dart';
import 'package:get/get.dart';

class DashController extends GetxController {
   final key = GlobalKey<ScaffoldState>();
  RxList<Widget> pages = RxList([
    HomeView(),
    HistoryView(),
    ProfileView(),
  ]);

  RxInt currentIndex = RxInt(0);
}

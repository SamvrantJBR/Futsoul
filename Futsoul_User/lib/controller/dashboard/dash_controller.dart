import 'package:flutter/material.dart';
import 'package:futsoul_user/views/dashboard/history_view.dart';
import 'package:futsoul_user/views/dashboard/home_view.dart';
import 'package:futsoul_user/views/dashboard/profile/profile_view.dart';
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

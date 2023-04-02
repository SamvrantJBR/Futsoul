import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/favorites_controller.dart';
import 'package:futsoul_user/views/futsal/futsal_scren.dart';
import 'package:futsoul_user/widget/custom/custom_appbar.dart';
import 'package:futsoul_user/widget/error_screen.dart';
import 'package:futsoul_user/widget/row/futsal_list.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  static const String routeName = "/favorites";
  final c = Get.find<FavoriteController>();
  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Favorites"),
      body: SafeArea(
        child: Obx(
          () {
            if (c.isLoading.value) {
              return const LinearProgressIndicator();
            } else if (!c.isLoading.value && c.futsals.isEmpty) {
              return const ErrorScreen();
            } else {
              return ListView.builder(
                controller: c.scrollController,
                padding: const EdgeInsets.all(20),
                itemCount: c.nextPage.value != null
                    ? c.futsals.length + 1
                    : c.futsals.length,
                itemBuilder: (context, index) {
                  if (index == c.futsals.length) {
                    return const LinearProgressIndicator();
                  }
                  var futsal = c.futsals[index];
                  return FutsalList(
                    futsal: futsal,
                    onTap: () {
                      Get.toNamed(FutsalScreen.routeName, arguments: [futsal]);
                    },
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

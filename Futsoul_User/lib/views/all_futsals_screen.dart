import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/all_futsal_controller.dart';
import 'package:futsoul_user/views/futsal/futsal_scren.dart';
import 'package:futsoul_user/widget/custom/custom_appbar.dart';
import 'package:futsoul_user/widget/custom/custome_textfield.dart';
import 'package:futsoul_user/widget/error_screen.dart';
import 'package:futsoul_user/widget/row/futsal_list.dart';
import 'package:get/get.dart';

class AllFutsalsScreen extends StatelessWidget {
  static const String routeName = "/all-futsals";
  final c = Get.find<AllFutsalController>();
  AllFutsalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Futsals"),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: c.scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  controller: c.searchController,
                  hint: "Search Futsal",
                  onSubmitted: (p0) {
                    c.searchFutsal();
                  },
                  onValueChange: (p0) {
                    c.searchFutsal();
                  },
                  textInputAction: TextInputAction.search,
                  textInputType: TextInputType.name,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () {
                  if (c.isLoading.value) {
                    return const LinearProgressIndicator();
                  } else if (!c.isLoading.value && c.futsals.isEmpty) {
                    return const ErrorScreen();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                            Get.toNamed(FutsalScreen.routeName,
                                arguments: [futsal]);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/off_days_controller.dart';
import 'package:futsoul_merchant/utils/colors.dart';
import 'package:futsoul_merchant/views/add_off_days.dart';
import 'package:futsoul_merchant/widget/custom/custom_appbar.dart';
import 'package:futsoul_merchant/widget/error_screen.dart';
import 'package:futsoul_merchant/widget/row/off_dary_row.dart';
import 'package:get/get.dart';

class OffDaysScreen extends StatelessWidget {
  static const String routeName = "/odd-days";
  final c = Get.find<OffDaysController>();
  OffDaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(title: "Off Days"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.toNamed(AddOffDaysScreen.routeName);
        },
        child: const Icon(
          Icons.add,
          color: AppColors.backGroundColor,
        ),
      ),
      body: Obx(() {
        if (c.isLoading.value) {
          return SizedBox(
            height: Get.height / 2,
            child: const Center(
              child: LinearProgressIndicator(),
            ),
          );
        } else if (!c.isLoading.value && c.offDays.isEmpty) {
          return const ErrorScreen();
        } else {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            controller: c.scrollController,
            shrinkWrap: true,
            itemCount: c.nextPage.value == null
                ? c.offDays.length
                : c.offDays.length + 1,
            itemBuilder: (context, index) {
              if (index == c.offDays.length && c.nextPage.value == null) {
                return Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: (c.nextPage.value != null)
                        ? const LinearProgressIndicator()
                        : null);
              }
              var offDay = c.offDays[index];
              return OffDayRow(
                offDay: offDay,
              );
            },
          );
        }
      }),
    );
  }
}

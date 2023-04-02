import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/dashboard/history_controller.dart';
import 'package:futsoul_merchant/utils/colors.dart';
import 'package:futsoul_merchant/utils/custom_text_styles.dart';
import 'package:futsoul_merchant/views/dashboard/histroy/active_view.dart';
import 'package:futsoul_merchant/views/dashboard/histroy/past_booking.dart';
import 'package:futsoul_merchant/views/dashboard/new_booking.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  final c = Get.find<HistoryController>();
  HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Get.toNamed(NewBookingScreen.routeName);
          },
          child: const Icon(
            Icons.add,
            color: AppColors.backGroundColor,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => InkWell(
                          onTap: () {
                            c.changeTab("active");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: c.selectedTab.value == "active"
                                    ? AppColors.primaryColor
                                    : AppColors.backGroundColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                )),
                            child: Text(
                              "Active Orders",
                              style: CustomTextStyles.f14W400(
                                color: c.selectedTab.value == "active"
                                    ? AppColors.backGroundColor
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => InkWell(
                          onTap: () {
                            c.changeTab("past");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: c.selectedTab.value == "past"
                                    ? AppColors.primaryColor
                                    : AppColors.backGroundColor,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            child: Text(
                              "Past Orders",
                              style: CustomTextStyles.f14W400(
                                color: c.selectedTab.value == "past"
                                    ? AppColors.backGroundColor
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  key: c.pageKey.value,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: c.pageController,
                  children: [ActiveBookingView(), PastBookingView()],
                ),
              ),
            ],
          ),
        ));
  }
}

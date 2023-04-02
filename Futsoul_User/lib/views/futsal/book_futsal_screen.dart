import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/futsal/futsal_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/date_time_helper.dart';
import 'package:futsoul_user/widget/custom/custom_appbar.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:futsoul_user/widget/row/date_card.dart';
import 'package:futsoul_user/widget/row/time_slot_card.dart';
import 'package:get/get.dart';

class BookFutsalScreen extends StatelessWidget {
  static const String routeName = "/book-futsal";
  final c = Get.find<FutsalController>();
  BookFutsalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => CustomElevatedButton(
            isDisabled: (c.selectedTimeSlot.value == null),
            title: "Book for Rs ${c.futsal.value!.price}",
            onTap: c.bookFutsal,
          ),
        ),
      ),
      appBar: const CustomAppBar(
        title: "Book Futsal",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Booking Time",
                style: CustomTextStyles.f16W400(),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => DateCard(
                      title: "Today",
                      date: DateTimeHelper.dateOnly(c.availableDates[0]),
                      isActive: c.selectedDateTime.value == c.dateKeys[0],
                      onTap: () {
                        c.selectDate(c.dateKeys[0]);
                      },
                    ),
                  ),
                  Obx(
                    () => DateCard(
                      title: "Tomorrow",
                      date: DateTimeHelper.dateOnly(c.availableDates[1]),
                      isActive: c.selectedDateTime.value == c.dateKeys[1],
                      onTap: () {
                        c.selectDate(c.dateKeys[1]);
                      },
                    ),
                  ),
                  Obx(
                    () => DateCard(
                      title: DateTimeHelper.dayOnly(c.availableDates[2]),
                      date: DateTimeHelper.dateOnly(c.availableDates[2]),
                      isActive: c.selectedDateTime.value == c.dateKeys[2],
                      onTap: () {
                        c.selectDate(c.dateKeys[2]);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Select Available Time Slot",
                style: CustomTextStyles.f16W400(),
              ),
              Obx(
                () => GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: ((Get.width - 70) / 2) / 45,
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: c.timeSlots[c.selectedDateTime.value]!.length,
                  itemBuilder: (context, index) {
                    var timeSlot =
                        c.timeSlots[c.selectedDateTime.value]![index];
                    return Obx(
                      () => TimeSlotCard(
                        timeSlot: timeSlot,
                        isSelected: (c.selectedTimeSlot.value != null &&
                            c.selectedTimeSlot.value == timeSlot),
                        onTap: () {
                          c.selectTimeSlot(timeSlot);
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 75,
              )
            ],
          ),
        ),
      ),
    );
  }
}

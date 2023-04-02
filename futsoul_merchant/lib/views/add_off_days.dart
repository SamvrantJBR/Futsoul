import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/add_off_days_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/off_days_controller.dart';
import 'package:futsoul_merchant/utils/colors.dart';
import 'package:futsoul_merchant/utils/custom_text_styles.dart';
import 'package:futsoul_merchant/utils/validators.dart';
import 'package:futsoul_merchant/widget/custom/custom_appbar.dart';
import 'package:futsoul_merchant/widget/custom/custome_textfield.dart';
import 'package:futsoul_merchant/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class AddOffDaysScreen extends StatelessWidget {
  static const String routeName = "/add-off-days";
  final c = Get.find<AddOffDaysController>();
  AddOffDaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Off Days"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: CustomElevatedButton(
          title: "Continue",
          onTap: c.onSubmit,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: c.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomTextField(
                    onTap: c.pickStartDate,
                    hint: "Start Date",
                    labelText: "Start Date",
                    readOnly: true,
                    controller: c.startDateController,
                    validator: Validators.checkFieldEmpty,
                    textInputAction: TextInputAction.none,
                    textInputType: TextInputType.none),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    onTap: c.pickEndDate,
                    hint: "End Date (Optional)",
                    labelText: "End Date (Optional)",
                    readOnly: true,
                    controller: c.endDateController,
                    textInputAction: TextInputAction.none,
                    textInputType: TextInputType.none),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    onTap: c.pickStartTime,
                    hint: "Start Time (Optional)",
                    labelText: "Start Time (Optional)",
                    readOnly: true,
                    controller: c.startTimeController,
                    textInputAction: TextInputAction.none,
                    textInputType: TextInputType.none),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    onTap: c.pickEndTime,
                    hint: "End Time (Optional)",
                    labelText: "End Time (Optional)",
                    readOnly: true,
                    controller: c.endTimeController,
                    textInputAction: TextInputAction.none,
                    textInputType: TextInputType.none),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Please apply for leave at least 3 days in advance to ensure timely processing",
                  style: CustomTextStyles.f16W400(color: AppColors.lGrey),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

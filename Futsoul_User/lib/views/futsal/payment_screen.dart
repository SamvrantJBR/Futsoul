import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/futsal/payment_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/dashboard/dash_screen.dart';
import 'package:futsoul_user/widget/custom/custom_appbar.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  static const String routeName = "/payment";
  final c = Get.find<PaymentController>();
  PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Get.until(
          (route) => route.settings.name == DashScreen.routeName,
        );
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Payment",
          onBack: () {
            Get.until(
              (route) => route.settings.name == DashScreen.routeName,
            );
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Payment Method",
                  style: CustomTextStyles.f16W400(),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: c.preceedPayment,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 1),
                            color: theme.colorScheme.shadow,
                            spreadRadius: 1,
                            blurRadius: 8),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          ImagePath.khaltiLogo,
                          height: 46,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Khalti",
                          style: CustomTextStyles.f16W400(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

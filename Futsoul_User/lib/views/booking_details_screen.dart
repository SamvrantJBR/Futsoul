import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/booking_details_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/dashboard/dash_screen.dart';
import 'package:futsoul_user/views/futsal/payment_screen.dart';
import 'package:futsoul_user/widget/custom/custom_appbar.dart';
import 'package:futsoul_user/widget/custom/dotted_line.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class BookingDetailScreen extends StatelessWidget {
  static const String routeName = "/booking-details";
  final c = Get.find<BookingDetailsController>();
  BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Get.until(
          (route) => route.settings.name == DashScreen.routeName,
        );
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: CustomAppBar(
            title: "Booking Details",
            color: AppColors.backGroundColor,
            onBack: () {
              Get.until(
                (route) => route.settings.name == DashScreen.routeName,
              );
            },
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: theme.colorScheme.background,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Text(
                          "${c.booking.value?.merchant?.futsalName}",
                          style: CustomTextStyles.f16W600(),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "${c.booking.value?.merchant?.location}",
                          style: CustomTextStyles.f12W400(),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "${c.booking.value?.status?.toUpperCase()}",
                          style: CustomTextStyles.f16W600(
                              color: AppColors.primaryColor),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 18,
                              width: 9,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  )),
                            ),
                            HorizontalDottedLine(
                              width: Get.width - 58,
                            ),
                            Container(
                              height: 18,
                              width: 9,
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    bottomLeft: Radius.circular(50),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        DataRow(
                          title1: "Booking ID",
                          title2: "Type",
                          data1: "#${c.booking.value?.transactionId}",
                          data2: '${c.booking.value?.type}',
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        DataRow(
                          title1: "Date",
                          title2: "Time",
                          data1: "${c.booking.value?.createdAt}",
                          data2:
                              '${c.booking.value?.startTime} - ${c.booking.value?.endTime}',
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        DataRow(
                          title1: "Price",
                          title2: "Payment Token",
                          data1: "Rs. ${c.booking.value?.price}",
                          data2: c.booking.value?.paymentToken ?? "None",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: c.booking.value?.merchant?.image ?? "",
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        ImagePath.imagePlaceholder,
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              if (c.booking.value!.status!.toLowerCase() != "cancelled" &&
                  c.booking.value!.status!.toLowerCase() != "completed")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                    backGroundColor: theme.colorScheme.background,
                    textColor: AppColors.errorColor.withOpacity(0.8),
                    title: "Cancel Booking",
                    onTap: () {
                      c.cancelBooking();
                    },
                  ),
                ),
              Obx(
                () => (c.booking.value?.paymentToken == null &&
                        (c.booking.value!.status!.toLowerCase() !=
                                "cancelled" &&
                            c.booking.value!.status!.toLowerCase() !=
                                "completed"))
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: CustomElevatedButton(
                          backGroundColor: theme.colorScheme.background,
                          textColor: AppColors.primaryColor.withOpacity(0.8),
                          title: "Make Payment",
                          onTap: () {
                            Get.toNamed(PaymentScreen.routeName,
                                arguments: [c.booking.value!]);
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: CustomElevatedButton(
                          backGroundColor: theme.colorScheme.background,
                          textColor: AppColors.primaryColor,
                          title: "Back To Home Page",
                          onTap: () {
                            Get.until(
                              (route) =>
                                  route.settings.name == DashScreen.routeName,
                            );
                          },
                        ),
                      ),
              )
            ],
          )),
    );
  }
}

class DataRow extends StatelessWidget {
  final String title1;
  final String title2;
  final String data1;
  final String data2;
  const DataRow({
    super.key,
    required this.title1,
    required this.title2,
    required this.data1,
    required this.data2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: CustomTextStyles.f12W400(
                      color: AppColors.secondaryTextColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  data1,
                  style:
                      CustomTextStyles.f12W600(color: AppColors.primaryColor),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title2,
                  style: CustomTextStyles.f12W400(
                      color: AppColors.secondaryTextColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  data2,
                  style:
                      CustomTextStyles.f12W600(color: AppColors.primaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

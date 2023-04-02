import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/dashboard/home_controller.dart';
import 'package:futsoul_merchant/utils/colors.dart';
import 'package:futsoul_merchant/utils/custom_text_styles.dart';
import 'package:futsoul_merchant/utils/image_path.dart';
import 'package:futsoul_merchant/widget/error_screen.dart';
import 'package:futsoul_merchant/widget/row/booking_list.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeView extends StatelessWidget {
  final c = Get.find<HomeController>();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (c.isLoadingBanner.value) {
                  return const LinearProgressIndicator();
                } else if (!c.isLoadingBanner.value && c.bannerImages.isEmpty) {
                  return Container();
                } else {
                  return CarouselSlider.builder(
                    itemCount: c.bannerImages.length,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: c.bannerImages[index].image ?? "",
                          fit: BoxFit.cover,
                          width: Get.width - 40,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                            ImagePath.imagePlaceholder,
                            fit: BoxFit.cover,
                            width: Get.width - 40,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 176,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Income Chart",
                style: CustomTextStyles.f16W600(),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => (c.isLoadingIncomes.value)
                    ? const LinearProgressIndicator()
                    : PieChart(
                        dataMap: {
                          "Online": c.online.value,
                          "Offline": c.offline.value
                        },
                        chartRadius: MediaQuery.of(context).size.width / 2.5,
                        colorList: const [
                          AppColors.primaryColor,
                          AppColors.errorColor
                        ],
                      ),
              ),
              Text(
                "Active Bookings",
                style: CustomTextStyles.f16W600(),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () {
                  if (c.isLoadingBokking.value) {
                    return const LinearProgressIndicator();
                  } else if (!c.isLoadingBokking.value && c.bookings.isEmpty) {
                    return const ErrorScreen();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: c.bookings.length,
                      itemBuilder: (context, index) {
                        var booking = c.bookings[index];
                        return BookingList(
                          booking: booking,
                          
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
    ));
  }
}

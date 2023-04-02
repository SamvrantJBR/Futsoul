import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/dashboard/home_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/all_futsals_screen.dart';
import 'package:futsoul_user/views/favorites_screen.dart';
import 'package:futsoul_user/views/futsal/futsal_scren.dart';
import 'package:get/get.dart';

import '../../widget/row/futsal_cart.dart';
import '../../widget/row/futsal_list.dart';

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
              Obx(
                () => (!c.isLoadingFavorites.value && c.favorites.isEmpty)
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Favorites Futsals",
                            style: CustomTextStyles.f16W600(),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(FavoritesScreen.routeName);
                              },
                              child: Text(
                                "View All",
                                style: CustomTextStyles.f16W600(
                                    color: AppColors.primaryColor),
                              ))
                        ],
                      ),
              ),
              Obx(
                () {
                  if (c.isLoadingFavorites.value) {
                    return const LinearProgressIndicator();
                  } else if (!c.isLoadingFavorites.value &&
                      c.favorites.isEmpty) {
                    return Container();
                  } else {
                    return SizedBox(
                      height: 131,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: c.favorites.length,
                        itemBuilder: (context, index) {
                          var futsal = c.favorites[index];
                          return FutsalCard(
                            futsal: futsal,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
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
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Futsals",
                    style: CustomTextStyles.f16W600(),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AllFutsalsScreen.routeName);
                      },
                      child: Text(
                        "View All",
                        style: CustomTextStyles.f16W600(
                            color: AppColors.primaryColor),
                      ))
                ],
              ),
              Obx(() {
                if (c.isLoadingFutsal.value) {
                  return const LinearProgressIndicator();
                } else if (!c.isLoadingFutsal.value && c.futsals.isEmpty) {
                  return Container();
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: c.futsals.length,
                    itemBuilder: (context, index) {
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
              }),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    ));
  }
}

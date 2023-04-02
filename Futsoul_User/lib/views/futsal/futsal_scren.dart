import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/futsal/futsal_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/futsal/book_futsal_screen.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class FutsalScreen extends StatelessWidget {
  static const String routeName = "/futsal-screen";
  final c = Get.find<FutsalController>();
  FutsalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          // if (c.isLoading.value) {
          //   return const LinearProgressIndicator();
          // } else if (!c.isLoading.value && !c.futsal.value!.isAvailable!) {
          //   return Container(
          //     decoration: BoxDecoration(
          //         color: AppColors.lGrey.withOpacity(0.5),
          //         borderRadius: BorderRadius.circular(10)),
          //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          //     child: Text(
          //       "The futsal is not availble at the moment",
          //       textAlign: TextAlign.center,
          //       style: CustomTextStyles.f16W600(
          //         color: AppColors.textColor,
          //       ),
          //     ),
          //   );
          // } else {
            return CustomElevatedButton(
              title: "Book Now",
              isDisabled: !c.canBook.value,
              onTap: () {
                Get.toNamed(BookFutsalScreen.routeName);
              },
            );
          // }
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Obx(
                  () => ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: c.futsal.value?.banner ?? "",
                      fit: BoxFit.cover,
                      height: 220,
                      width: Get.width,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        ImagePath.imagePlaceholder,
                        fit: BoxFit.cover,
                        height: 220,
                        width: Get.width,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFFE5E5E5),
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: AppColors.textColor,
                              )),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap:
                                  c.isLoadingFav.value ? null : c.saveFavorite,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xFFF8F8F8),
                                child: (c.isLoadingFav.value)
                                    ? const SizedBox(
                                        height: 23,
                                        width: 23,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                        ),
                                      )
                                    : (!c.isFavorite.value)
                                        ? const Icon(
                                            Icons.favorite_border,
                                            size: 20,
                                            color: AppColors.secondaryTextColor,
                                          )
                                        : const Icon(
                                            Icons.favorite,
                                            size: 20,
                                            color: AppColors.errorColor,
                                          ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => c.isLoading.value
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: LinearProgressIndicator(),
                    )
                  : Container(),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: c.futsal.value?.image ?? "",
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                          ImagePath.imagePlaceholder,
                          fit: BoxFit.cover,
                          height: 90,
                          width: 90,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      height: 90,
                      width: Get.width - 146,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${c.futsal.value?.futsalName}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.f16W600(),
                          ),
                          Text(
                            "${c.futsal.value?.location}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.f16W300(),
                          ),
                          Text(
                            "Rs ${c.futsal.value?.price} per hour",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.f16W600(
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Description",
                style: CustomTextStyles.f16W400(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  c.futsal.value?.description ?? "No description",
                  style: CustomTextStyles.f12W400(
                    color: AppColors.secondaryTextColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Contact Details",
                style: CustomTextStyles.f16W600(),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.alternate_email_outlined,
                      size: 14,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${c.futsal.value?.email}",
                      style: CustomTextStyles.f14W400(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 14,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${c.futsal.value?.phone}",
                      style: CustomTextStyles.f14W400(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 90,
            )
          ],
        ),
      ),
    );
  }
}

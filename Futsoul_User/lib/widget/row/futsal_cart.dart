import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/views/futsal/futsal_scren.dart';
import 'package:get/get.dart';
import '../../models/futsals.dart';

class FutsalCard extends StatelessWidget {
  final Futsal futsal;
  const FutsalCard({
    super.key,
    required this.futsal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(FutsalScreen.routeName, arguments: [futsal]);
      },
      child: Container(
        height: 131,
        width: 200,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: futsal.image ?? "",
                fit: BoxFit.cover,
                height: 131,
                width: 200,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  ImagePath.imagePlaceholder,
                  fit: BoxFit.cover,
                  height: 131,
                  width: 200,
                ),
              ),
            ),
            Container(
              height: 131,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.black12, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${futsal.futsalName}",
                    style: CustomTextStyles.f12W600(color: Colors.white),
                  ),
                  Text(
                    "${futsal.location}",
                    style: CustomTextStyles.f12W300(color: Colors.white),
                  ),
                  Text(
                    "Rs ${futsal.price} per hour",
                    style: CustomTextStyles.f12W600(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

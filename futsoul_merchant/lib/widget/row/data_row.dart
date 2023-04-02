import 'package:flutter/material.dart';
import 'package:futsoul_merchant/utils/colors.dart';
import 'package:futsoul_merchant/utils/custom_text_styles.dart';

class RowData extends StatelessWidget {
  final String title1;
  final String title2;
  final String data1;
  final String data2;
  const RowData({
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
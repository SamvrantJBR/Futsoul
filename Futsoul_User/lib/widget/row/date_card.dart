import 'package:flutter/material.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';

class DateCard extends StatelessWidget {
  final String title;
  final String date;
  final bool isActive;
  final VoidCallback onTap;
  const DateCard({
    super.key,
    required this.title,
    required this.date,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : theme.colorScheme.background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  color: theme.colorScheme.shadow)
            ]),
        child: Column(
          children: [
            Text(
              title,
              style: CustomTextStyles.f12W400(
                  color:
                      isActive ? AppColors.backGroundColor : theme.colorScheme.onBackground),
            ),
            Text(
              date,
              style: CustomTextStyles.f10W400(
                  color:
                      isActive ? AppColors.backGroundColor : theme.colorScheme.onBackground),
            )
          ],
        ),
      ),
    );
  }
}
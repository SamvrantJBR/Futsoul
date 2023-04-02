import 'package:flutter/material.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomOutlinedButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(width: 1, color: AppColors.primaryColor),
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: CustomTextStyles.f16W600(color: AppColors.primaryColor),
        ));
  }
}
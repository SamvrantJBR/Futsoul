import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';

class CustomBottomNavIcon extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  const CustomBottomNavIcon({
    super.key,
    required this.imagePath,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            imagePath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
                isActive ? AppColors.primaryColor : theme.colorScheme.onBackground,
                BlendMode.srcIn),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: CustomTextStyles.f12W300(
              color: isActive ? AppColors.primaryColor : theme.colorScheme.onBackground,
            ),
          )
        ],
      ),
    );
  }
}

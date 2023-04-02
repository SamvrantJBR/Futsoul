import 'package:flutter/material.dart';
import 'package:futsoul_merchant/utils/custom_text_styles.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? color;
  final VoidCallback? onBack;
  final bool showBack;
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.color,
    this.onBack,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
      leading: showBack
          ? IconButton(
              onPressed: onBack ??
                  () {
                    Get.back();
                  },
              icon: Icon(
                Icons.arrow_back,
                color: color ?? theme.colorScheme.onBackground,
              ),
            )
          : Container(),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title,
        style: CustomTextStyles.f18W600(
            color: color ?? theme.colorScheme.onBackground),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

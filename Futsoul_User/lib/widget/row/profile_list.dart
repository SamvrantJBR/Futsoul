import 'package:flutter/material.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';

class ProfileTile extends StatelessWidget {
  final Color? color;
  final bool showTrailing;
  final String title;
  final IconData leadingIcon;
  final VoidCallback onTap;
  const ProfileTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.color,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Icon(
        leadingIcon,
        color: color?? theme.colorScheme.onBackground,
      ),
      trailing: showTrailing
          ? Icon(
              Icons.chevron_right,
              color: color?? theme.colorScheme.onBackground,
            )
          : null,
      title: Text(
        title,
        style: CustomTextStyles.f16W400(color: color?? theme.colorScheme.onBackground),
      ),
    );
  }
}

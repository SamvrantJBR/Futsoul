import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/core_controller.dart';
import 'package:futsoul_user/widget/custom/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class ChangeThemeScreen extends StatelessWidget {
  static const String routeName = "/change-theme";
  final c = Get.find<CoreController>();
  ChangeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(title: "Theme"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Obx(
                () => InkWell(
                  onTap: () {
                    c.updateTheme(ThemeMode.light);
                  },
                  child: SizedBox(
                    height: 48,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.light_mode_outlined,
                            size: 28,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              "Light mode",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: c.themeMode.value == ThemeMode.light,
                            child: Icon(
                              Icons.check,
                              size: 28,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Divider(
                color: theme.colorScheme.outline,
              ),
              Obx(
                () => InkWell(
                  onTap: () {
                    c.updateTheme(ThemeMode.dark);
                  },
                  child: SizedBox(
                    height: 48,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dark_mode_outlined,
                            size: 28,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              "Dark mode",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: c.themeMode.value == ThemeMode.dark,
                            child: Icon(
                              Icons.check,
                              size: 28,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Divider(
                color: theme.colorScheme.outline,
              ),
              Obx(
                () => InkWell(
                  onTap: () {
                    c.updateTheme(ThemeMode.system);
                  },
                  child: SizedBox(
                    height: 48,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            size: 28,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              "System mode",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: c.themeMode.value == ThemeMode.system,
                            child: Icon(
                              Icons.check,
                              size: 28,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

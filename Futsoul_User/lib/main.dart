import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/core_controller.dart';
import 'package:futsoul_user/utils/config.dart';
import 'package:futsoul_user/utils/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'utils/pages.dart';
import 'views/splash_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const FutsoulApp());
}

class FutsoulApp extends StatelessWidget {
  const FutsoulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: Config.khaltiPublicKeyTest,
      builder: (context, navigatorKey) {
        return GetBuilder<CoreController>(
          init: Get.put(CoreController()),
          builder: (controller) {
            return GetMaterialApp(
          localizationsDelegates: const [KhaltiLocalizations.delegate],
            navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          getPages: pages,
          theme: basicTheme(),
          themeMode: controller.themeMode.value,
          darkTheme: darkTheme(),
          initialRoute: SplashScreen.routeName,
        );  
          },
        );
      },
    );
  }
}

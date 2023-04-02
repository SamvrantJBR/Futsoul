import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/core_controller.dart';
import 'package:futsoul_merchant/utils/pages.dart';
import 'package:futsoul_merchant/utils/theme.dart';
import 'package:futsoul_merchant/views/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FutsoulMerchantApp());
}

class FutsoulMerchantApp extends StatelessWidget {
  const FutsoulMerchantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoreController>(
      init: Get.put(CoreController()),
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: pages,
          theme: basicTheme(),
          themeMode: controller.themeMode.value,
          darkTheme: darkTheme(),
          initialRoute: SplashScreen.routeName,
        );
      },
    );
  }
}

import 'package:futsoul_user/controller/core_controller.dart';
import 'package:futsoul_user/views/dashboard/dash_screen.dart';
import 'package:futsoul_user/views/welcome_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final coreController = Get.find<CoreController>();

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (coreController.isUserLoggedIn()) {
          Get.offAndToNamed(DashScreen.routeName);
        } else {
          Get.offAllNamed(WelcomeScreen.routeName);
        }
      },
    );
    super.onInit();
  }
}

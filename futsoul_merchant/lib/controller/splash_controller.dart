import 'package:futsoul_merchant/controller/core_controller.dart';
import 'package:futsoul_merchant/views/dashboard/dash_screen.dart';
import 'package:futsoul_merchant/views/welcome_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final coreController = Get.find<CoreController>();
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (coreController.isUserLoggedIn()) {
          if (coreController.currentUser.value!.isCompleted!) {
            Get.offAndToNamed(DashScreen.routeName);
          } else {
            Get.to(WelcomeScreen.routeName);
          }
        } else {
          Get.offAllNamed(WelcomeScreen.routeName);
        }
      },
    );
    super.onInit();
  }
}

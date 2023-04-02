import 'package:futsoul_merchant/controller/core_controller.dart';
import 'package:futsoul_merchant/models/user.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  final coreController  = Get.find<CoreController>();

  Rxn<User> user = Rxn<User>(); 

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  void loadUser(){
    user.value = coreController.currentUser.value;
  }

}

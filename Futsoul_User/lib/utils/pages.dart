import 'package:futsoul_user/controller/all_futsal_controller.dart';
import 'package:futsoul_user/controller/auth/forget_password_controller.dart';
import 'package:futsoul_user/controller/auth/login_controller.dart';
import 'package:futsoul_user/controller/auth/otp_controller.dart';
import 'package:futsoul_user/controller/auth/reset_password_controller.dart';
import 'package:futsoul_user/controller/auth/signup_controller.dart';
import 'package:futsoul_user/controller/booking_details_controller.dart';
import 'package:futsoul_user/controller/dashboard/dash_controller.dart';
import 'package:futsoul_user/controller/dashboard/history_controller.dart';
import 'package:futsoul_user/controller/dashboard/home_controller.dart';
import 'package:futsoul_user/controller/dashboard/profile/change_password_controller.dart';
import 'package:futsoul_user/controller/dashboard/profile/edit_profile_controller.dart';
import 'package:futsoul_user/controller/dashboard/profile/profile_controller.dart';
import 'package:futsoul_user/controller/favorites_controller.dart';
import 'package:futsoul_user/controller/futsal/futsal_controller.dart';
import 'package:futsoul_user/controller/futsal/payment_controller.dart';
import 'package:futsoul_user/controller/splash_controller.dart';
import 'package:futsoul_user/views/all_futsals_screen.dart';
import 'package:futsoul_user/views/booking_details_screen.dart';
import 'package:futsoul_user/views/dashboard/profile/change_password_screen.dart';
import 'package:futsoul_user/views/auth/forget_password_screen.dart';
import 'package:futsoul_user/views/auth/login_screen.dart';
import 'package:futsoul_user/views/auth/opt_screen.dart';
import 'package:futsoul_user/views/auth/reset_password_screen.dart';
import 'package:futsoul_user/views/auth/signup_screen.dart';
import 'package:futsoul_user/views/dashboard/dash_screen.dart';
import 'package:futsoul_user/views/dashboard/profile/change_theme_screen.dart';
import 'package:futsoul_user/views/dashboard/profile/edit_profile_screen.dart';
import 'package:futsoul_user/views/favorites_screen.dart';
import 'package:futsoul_user/views/futsal/book_futsal_screen.dart';
import 'package:futsoul_user/views/futsal/futsal_scren.dart';
import 'package:futsoul_user/views/futsal/payment_screen.dart';
import 'package:futsoul_user/views/splash_screen.dart';
import 'package:futsoul_user/views/welcome_screen.dart';
import 'package:get/get.dart';

var pages = [
  GetPage(
    name: SplashScreen.routeName,
    page: () => SplashScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => SplashController(),
        )),
  ),
  GetPage(
    name: WelcomeScreen.routeName,
    page: () => const WelcomeScreen(),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () => LoginScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => LoginController(),
        )),
  ),
  GetPage(
    name: SignupScreen.routeName,
    page: () => SignupScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => SignupController(),
        )),
  ),
  GetPage(
    name: ForgetPasswordScreen.routeName,
    page: () => ForgetPasswordScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => ForgetPasswordController(),
        )),
  ),
  GetPage(
    name: OTPScreen.routeName,
    page: () {
      var data = Get.arguments;
      var email = data[0];
      return OTPScreen(
        email: email,
      );
    },
    binding: BindingsBuilder(() => Get.lazyPut(
          () => OTPController(),
        )),
  ),
  GetPage(
    name: ResetPasswordScreen.routeName,
    page: () {
      var data = Get.arguments;
      var email = data[0];
      return ResetPasswordScreen(
        email: email,
      );
    },
    binding: BindingsBuilder(() => Get.lazyPut(
          () => ResetPasswordController(),
        )),
  ),
  GetPage(
    name: DashScreen.routeName,
    page: () => DashScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(
        () => DashController(),
      );
      Get.lazyPut(
        () => HomeController(),
      );
      Get.lazyPut(
        () => HistoryController(),
      );
      Get.lazyPut(
        () => ProfileController(),
      );
    }),
  ),
  GetPage(
    name: FutsalScreen.routeName,
    page: () => FutsalScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => FutsalController(),
        )),
  ),
  GetPage(
    name: BookFutsalScreen.routeName,
    page: () => BookFutsalScreen(),
  ),
  GetPage(
    name: ChangeThemeScreen.routeName,
    page: () => ChangeThemeScreen(),
  ),
  GetPage(
    name: EditProfileScreen.routeName,
    page: () => EditProfileScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => EditProfileController(),
        )),
  ),
  GetPage(
    name: ChangePasswordScreen.routeName,
    page: () => ChangePasswordScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => ChangePasswordController(),
        )),
  ),
  GetPage(
    name: FavoritesScreen.routeName,
    page: () => FavoritesScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => FavoriteController(),
        )),
  ),
  GetPage(
    name: AllFutsalsScreen.routeName,
    page: () => AllFutsalsScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => AllFutsalController(),
        )),
  ),
  GetPage(
    name: PaymentScreen.routeName,
    page: () => PaymentScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => PaymentController(),
        )),
  ),
  GetPage(
    name: BookingDetailScreen.routeName,
    page: () => BookingDetailScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => BookingDetailsController(),
        )),
  ),
];

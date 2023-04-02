import 'package:futsoul_merchant/controller/add_off_days_controller.dart';
import 'package:futsoul_merchant/controller/auth/complete_profile_controller.dart';
import 'package:futsoul_merchant/controller/auth/forget_password_controller.dart';
import 'package:futsoul_merchant/controller/auth/login_controller.dart';
import 'package:futsoul_merchant/controller/auth/otp_controller.dart';
import 'package:futsoul_merchant/controller/auth/reset_password_controller.dart';
import 'package:futsoul_merchant/controller/auth/signup_controller.dart';
import 'package:futsoul_merchant/controller/booking/new_booking_controller.dart';
import 'package:futsoul_merchant/controller/booking_details_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/dash_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/history_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/home_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/change_password_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/edit_profile_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/off_days_controller.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/profile_controller.dart';
import 'package:futsoul_merchant/controller/splash_controller.dart';
import 'package:futsoul_merchant/views/add_off_days.dart';
import 'package:futsoul_merchant/views/auth/complete_profile_screen.dart';
import 'package:futsoul_merchant/views/auth/forget_password_screen.dart';
import 'package:futsoul_merchant/views/auth/login_screen.dart';
import 'package:futsoul_merchant/views/auth/opt_screen.dart';
import 'package:futsoul_merchant/views/auth/reset_password_screen.dart';
import 'package:futsoul_merchant/views/auth/signup_screen.dart';
import 'package:futsoul_merchant/views/booking_details_screen.dart';
import 'package:futsoul_merchant/views/dashboard/dash_screen.dart';
import 'package:futsoul_merchant/views/dashboard/new_booking.dart';
import 'package:futsoul_merchant/views/dashboard/profile/change_password_screen.dart';
import 'package:futsoul_merchant/views/dashboard/profile/change_theme_screen.dart';
import 'package:futsoul_merchant/views/dashboard/profile/edit_profile_screen.dart';
import 'package:futsoul_merchant/views/dashboard/profile/off_days_screen.dart';
import 'package:futsoul_merchant/views/splash_screen.dart';
import 'package:futsoul_merchant/views/welcome_screen.dart';
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
    name: CompleteProfileScreen.routeName,
    page: () => CompleteProfileScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => CompleteProfileController(),
        )),
  ),
  GetPage(
    name: ChangeThemeScreen.routeName,
    page: () => ChangeThemeScreen(),
  ),
  GetPage(
    name: ChangePasswordScreen.routeName,
    page: () => ChangePasswordScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => ChangePasswordController(),
        )),
  ),
  GetPage(
    name: EditProfileScreen.routeName,
    page: () => EditProfileScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => EditProfileController(),
        )),
  ),
  GetPage(
    name: BookingDetailScreen.routeName,
    page: () => BookingDetailScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => BookingDetailsController(),
        )),
  ),
  GetPage(
    name: OffDaysScreen.routeName,
    page: () => OffDaysScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => OffDaysController(),
        )),
  ),
  GetPage(
    name: AddOffDaysScreen.routeName,
    page: () => AddOffDaysScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => AddOffDaysController(),
        ))
  ),
  GetPage(
    name: NewBookingScreen.routeName,
    page: () => NewBookingScreen(),
    binding: BindingsBuilder(() => Get.lazyPut(
          () => BookingController(),
        ))
  ),
];

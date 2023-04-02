class Api {
  static const String baseUrl = "https://coolkapada.com/api";
  static const String prefix = "/merchant";
  static const String bannersUrl = "$baseUrl/banners";
  static const String incomesUrl = "$baseUrl$prefix/incomes";
  static const String loginUrl = "$baseUrl$prefix/login";
  static const String registerUrl = "$baseUrl$prefix/register";
  static const String forgotPasswordUrl = "$baseUrl$prefix/forgot-password";
  static const String completeProfileUrl = "$baseUrl$prefix/complete-profile";
  static const String updateProfileUrl = "$baseUrl$prefix/update";
  static const String completeBookingUrl = "$baseUrl$prefix/completeBooking";
  static const String cancelBookingUrl = "$baseUrl$prefix/completeBooking";
  static const String resetPasswordUrl =
      "$baseUrl$prefix/reset-forgot-password";
  static const String changePasswordUrl =
      "$baseUrl$prefix/reset-password";
  
  static const String getActiveBookingsUrl = "$baseUrl$prefix/active-bookings";
  static const String getPastBookingsUrl = "$baseUrl$prefix/past-bookings";
  static const String newBookingsUrl = "$baseUrl$prefix/add-booking";
  static const String getOffDaysUrl = "$baseUrl$prefix/list-offdays";
  static const String addOffDaysUrl = "$baseUrl$prefix/add-offdays";
  static const String futsalsDetailsUrl = "$baseUrl/futsals/show";
}

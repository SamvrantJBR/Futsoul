class Api {
  static const String baseUrl = "https://coolkapada.com/api";
  static const String loginUrl = "$baseUrl/user/login";
  static const String registerUrl = "$baseUrl/user/register";
  static const String forgotPasswordUrl = "$baseUrl/user/forgot-password";
  static const String resetPasswordUrl = "$baseUrl/user/reset-forgot-password";
  static const String updateProfileUrl = "$baseUrl/user/update-profile";
  static const String changePasswordUrl = "$baseUrl/user/reset-password";
  static const String bannersUrl = "$baseUrl/banners";
  static const String futsalsUrl = "$baseUrl/futsals/list";
  static const String searchFutsalsUrl = "$baseUrl/search";
  static const String futsalsDetailsUrl = "$baseUrl/futsals/show";
  static const String favoriteToogleUrl = "$baseUrl/user/toggle-favourite";
  static const String favoritesUrl = "$baseUrl/user/favourites";
  static const String isFavoriteUrl = "$baseUrl/user/is-favourite";
  static const String getBookingsUrl = "$baseUrl/user/bookings";
  static const String newBookingsUrl = "$baseUrl/user/book";
  static const String cancelBooking = "$baseUrl/user/cancel";
  static const String paymentCheckUrl = "$baseUrl/user/complete-payment";
}

import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_user/utils/api.dart';
import 'package:futsoul_user/utils/http_request.dart';

import 'package:http/http.dart' as http;

class ForgetPasswordRepo {
  static Future<void> forgetPassword({
    required String email,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      var body = {
        "email": email,
      };

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.forgotPasswordUrl),
          headers: headers,
          body: body);

      log("${Api.forgotPasswordUrl} ===================>");
      log(json.encode(body));
      log(response.body);

      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        onSuccess(data['message']);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }

  static Future<void> resetPassword({
    required String otp,
    required String password,
    required String email,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      var body = {
        "email": email,
        "otp": otp,
        "new_password": password,
      };

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.resetPasswordUrl),
          headers: headers,
          body: body);

      log("${Api.resetPasswordUrl} ===================>");
      log(json.encode(body));
      log(response.body);

      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        onSuccess(data['message']);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }
}

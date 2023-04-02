import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_user/models/access_token.dart';
import 'package:futsoul_user/utils/api.dart';
import 'package:futsoul_user/utils/http_request.dart';

import '../../models/user.dart';
import 'package:http/http.dart' as http;

class RegisterRepo {
  static Future<void> register({
    required String email,
    required String password,
    required String phone,
    required String name,
    required Function(User user, AccessToken token) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      var body = {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      };

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.registerUrl),
          headers: headers,
          body: body);

      log("${Api.registerUrl} ===================>");
      log(json.encode(body));
      log(response.body);

      dynamic data = jsonDecode(response.body);
      if (data["status"]) {
        AccessToken token = AccessToken.fromJson(data["data"]["accessToken"]);
        User user = User.fromJson(data["data"]["user"]);
        onSuccess(user, token);
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

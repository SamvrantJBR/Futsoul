// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_merchant/models/access_token.dart';
import 'package:futsoul_merchant/models/user.dart';
import 'package:get_storage/get_storage.dart';

class StorageKeys {
  static const String USER = "user";
  static const String ACCESS_TOKEN = "accessToken";
}

class StorageHelper {
  static AccessToken? getToken() {
    try {
      final box = GetStorage();
      AccessToken token = AccessToken.fromJson(
          jsonDecode(box.read(StorageKeys.ACCESS_TOKEN)) ?? "");
      return token;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

   static User? getUser() {
    log("Fetching user");
    try {
      final box = GetStorage();
      log("${box.read(StorageKeys.USER)}");
      User user = User.fromJson(json.decode(box.read(StorageKeys.USER)));

      return user;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return null;
    }
  }
}

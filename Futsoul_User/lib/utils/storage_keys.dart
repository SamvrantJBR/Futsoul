// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_user/models/access_token.dart';
import 'package:futsoul_user/models/user.dart';
import 'package:get_storage/get_storage.dart';

class StorageKeys {
  static const String USER = "user";
  static const String ACCESS_TOKEN = "accessToken";
}

class StorageHelper {
  static AccessToken? getToken() {
    log("Fetching token");
    try {
      final box = GetStorage();
      log("${box.read(StorageKeys.ACCESS_TOKEN)}");
      AccessToken token = AccessToken.fromJson(
          jsonDecode(box.read(StorageKeys.ACCESS_TOKEN)) ?? "");
      return token;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
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

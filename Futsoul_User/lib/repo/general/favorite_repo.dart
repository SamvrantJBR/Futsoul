import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_user/models/futsals.dart';
import 'package:futsoul_user/utils/api.dart';
import 'package:futsoul_user/utils/http_request.dart';
import 'package:futsoul_user/utils/storage_keys.dart';
import 'package:http/http.dart' as http;

class FavoriteRepo {
  static Future<void> toogleFavorite({
    required int id,
    required Function(bool isFav) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.favoriteToogleUrl;

      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      var body = {"merchant_id": id.toString()};

      http.Response response =
          await HttpRequest.post(Uri.parse(url), headers: headers, body: body);

      log("$url ===========>");
      log(body.toString());
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['status']) {
        var isFav = data['data']['isFavourite'];
        onSuccess(isFav);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> isFavorite({
    required int id,
    required Function(bool isFav) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.isFavoriteUrl;

      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      var body = {"merchant_id": id.toString()};

      http.Response response =
          await HttpRequest.post(Uri.parse(url), headers: headers, body: body);

      log("$url ===========>");
      log(body.toString());
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['status']) {
        var isFav = data['data']['isFavourite'];
        onSuccess(isFav);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> getFavorites({
    int? currentPage,
    required Function(List<Futsal> futsals, int? nextPage) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.favoritesUrl;

      if (currentPage != null) {
        url = "${Api.favoritesUrl}?page=$currentPage";
      }

      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      http.Response response = await HttpRequest.get(
        Uri.parse(url),
        headers: headers,
      );

      log("$url ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['status']) {
        List<Futsal> futsals = futsalsFromJson(data["data"]["data"]);
        int? nextPage;
        if (data['data']["current_page"] == data['data']["pages"] && data['data']["pages"] > 1) {
          nextPage = data['data']["current_page"] + 1;
        }
        onSuccess(futsals, nextPage);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }
}

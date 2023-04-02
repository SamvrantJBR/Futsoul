import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_user/models/banner.dart';
import 'package:futsoul_user/models/futsals.dart';
import 'package:futsoul_user/models/time_slot.dart';
import 'package:futsoul_user/utils/api.dart';
import 'package:futsoul_user/utils/http_request.dart';
import 'package:futsoul_user/utils/storage_keys.dart';
import 'package:http/http.dart' as http;

class FutsalRepo {
  static Future<void> getFutsals({
    int? currentPage,
    required Function(List<Futsal> futsals, int? nextPage) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.futsalsUrl;

      if (currentPage != null) {
        url = "${Api.futsalsUrl}?page=$currentPage";
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

  static Future<void> getFutsalDetails({
    required int id,
    required Function(Futsal futsal, Map<String, List<TimeSlot>> slots)
        onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = "${Api.futsalsDetailsUrl}?id=$id";

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
        Futsal futsal = Futsal.fromJson(data['data']['futsal']);
        Map<String, List<TimeSlot>> slots = <String, List<TimeSlot>>{};
        for (var slot in data['data']['slots']) {
          List<TimeSlot> timeslots = timeSlotsFromJson(slot);
          String key = timeslots[0].date!;
          slots[key] = timeslots;
        }
        onSuccess(futsal, slots);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> searchFutsals({
    required String query,
    required Function(List<Futsal> futsals) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = "${Api.searchFutsalsUrl}?search=$query";

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
        onSuccess(futsals);
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

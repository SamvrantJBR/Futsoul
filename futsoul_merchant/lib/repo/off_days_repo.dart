
import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_merchant/models/off_day.dart';
import 'package:futsoul_merchant/utils/api.dart';
import 'package:futsoul_merchant/utils/http_request.dart';
import 'package:futsoul_merchant/utils/storage_keys.dart';
import 'package:http/http.dart' as http;

class OffDyasRepo{

  static Future<void> getOffDays({
    int? currentPage,
    required Function(List<OffDay> offDyas, int? nextPage) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getOffDaysUrl;

      if (currentPage != null) {
        url = "${Api.getOffDaysUrl}?page=$currentPage";
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
        List<OffDay> offDays = offDaysFromJson(data["data"]["data"]);
        int? nextPage;
        if (data['data']["current_page"] < data['data']["pages"] &&
            data['data']["pages"] > 1) {
          nextPage = data['data']["current_page"] + 1;
        }
        onSuccess(offDays, nextPage);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> addOffDays({
    required String startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async{

    try {
      String url = Api.addOffDaysUrl;

      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      var body = {
        "start_date": startDate,
        "end_date": endDate??"",
        "start_time": startTime??"",
        "end_time": endTime??""
      };

      http.Response response = await HttpRequest.post(
        Uri.parse(url),
        headers: headers,
        body: body
      );

      log("$url ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['status']) {
         onSuccess(data['message']);
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
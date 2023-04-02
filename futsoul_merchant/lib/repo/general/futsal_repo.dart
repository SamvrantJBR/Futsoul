import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_merchant/models/time_slot.dart';
import 'package:futsoul_merchant/models/user.dart';
import 'package:futsoul_merchant/utils/http_request.dart';
import 'package:futsoul_merchant/utils/storage_keys.dart';
import 'package:http/http.dart' as http;

import '../../utils/api.dart';

class FutsalRepo {
  static Future<void> getFutsalDetails({
    required int id,
    required Function(User futsal, Map<String, List<TimeSlot>> slots)
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
        User futsal = User.fromJson(data['data']['futsal']);
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
}

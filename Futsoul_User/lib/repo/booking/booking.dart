import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_user/models/booking.dart';
import 'package:futsoul_user/utils/api.dart';
import 'package:futsoul_user/utils/http_request.dart';
import 'package:futsoul_user/utils/storage_keys.dart';
import 'package:http/http.dart' as http;

class BookingRepo {
  static Future<void> getBookings({
    int? currentPage,
    required Function(List<Booking> bookings, int? nextPage) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getBookingsUrl;

      if (currentPage != null) {
        url = "${Api.getBookingsUrl}?page=$currentPage";
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
        List<Booking> bookings = bookingsFromJson(data["data"]["data"]);
        int? nextPage;
        if (data['data']["current_page"] < data['data']["pages"] &&
            data['data']["pages"] > 1) {
          nextPage = data['data']["current_page"] + 1;
        }
        onSuccess(bookings, nextPage);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> newBookig({
    required int merchantId,
    required String date,
    required String startTime,
    required String endTime,
    required Function(Booking booking) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.newBookingsUrl;

      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      var body = {
        "merchant_id": merchantId.toString(),
        "date": date,
        "start_time": startTime,
        "end_time": endTime
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
        var booking = Booking.fromJson(data['data']);
        onSuccess(booking);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> cancelBooking({
    required String transactionId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async{

    try {
      String url = Api.cancelBooking;

      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      var body = {
        "transactionId": transactionId,
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

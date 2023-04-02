
import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_merchant/controller/core_controller.dart';
import 'package:futsoul_merchant/models/booking.dart';
import 'package:futsoul_merchant/utils/api.dart';
import 'package:futsoul_merchant/utils/http_request.dart';
import 'package:futsoul_merchant/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookingRepo{

  static Future<void> getActiveBookings({
    int? currentPage,
    required Function(List<Booking> bookings, int? nextPage) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getActiveBookingsUrl;

      if (currentPage != null) {
        url = "${Api.getActiveBookingsUrl}?page=$currentPage";
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

  static Future<void> getPastBookings({
    int? currentPage,
    required Function(List<Booking> bookings, int? nextPage) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getPastBookingsUrl;

      if (currentPage != null) {
        url = "${Api.getPastBookingsUrl}?page=$currentPage";
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
    required String date,
    required String startTime,
    required String endTime,
    required String fullName,
    required String phone,
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
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "full_name": fullName,
        "email": "none",
        "phone": phone,
        "price": Get.find<CoreController>().currentUser.value!.price!.toString()
      };

      http.Response response = await HttpRequest.post(
        Uri.parse(url),
        headers: headers,
        body: body
      );

      log("$url ===========>");
      log("$body ===========>");
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

  static Future<void> complete({
    required String transactionId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async{

    try {
      String url = Api.completeBookingUrl;

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

  static Future<void> cancel({
    required String transactionId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async{

    try {
      String url = Api.cancelBookingUrl;

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
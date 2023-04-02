import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_user/models/booking.dart';
import 'package:futsoul_user/utils/api.dart';
import 'package:futsoul_user/utils/http_request.dart';
import 'package:futsoul_user/utils/storage_keys.dart';
import "package:http/http.dart" as http;

class PaymentRepo {
  static Future<void> verifyKhaltiPayment({
    required String transactionId,
    required String pidx,
    required String amount,
    required String token,
    required Function(Booking booking) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var accesstoken = StorageHelper.getToken();
      var headers = {
        "Accept": "application/json",
        "Authorization": accesstoken.toString(),
      };

      var body = {
        "transactionId": transactionId,
        "pidx": pidx,
        "amount": "10",
        "token": token
      };
      
      log(body.toString());

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.paymentCheckUrl),
          headers: headers,
          body: body);

      log("${Api.paymentCheckUrl} =========> ");
      log(response.body.toString());
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
      onError("Sorry something went wring");
    }
  }
}

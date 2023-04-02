import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:futsoul_merchant/models/user.dart';
import 'package:futsoul_merchant/utils/api.dart';
import 'package:futsoul_merchant/utils/storage_keys.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:futsoul_merchant/utils/http_request.dart';

class CompleteProfileRepo {
  static Future<void> completeProfile(
      {required String name,
      required String phone,
      required String address,
      required String price,
      required String startTime,
      required String endTime,
      required File image,
      required File bannerImage,
      required Function(User user, String message) onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": token.toString()
      };

      var url = Uri.parse(Api.completeProfileUrl);
      http.MultipartRequest request = http.MultipartRequest("POST", url);
      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['location'] = address;
      request.fields['price'] = price;
      request.fields['start_time'] = startTime;
      request.fields['end_time'] = endTime;
      request.files.add(
        http.MultipartFile.fromBytes(
          "image",
          await image.readAsBytes(),
          filename: "image",
          contentType: MediaType("image", "*"),
        ),
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          "banner",
          await bannerImage.readAsBytes(),
          filename: "banner",
          contentType: MediaType("image", "*"),
        ),
      );
      http.StreamedResponse response = await HttpRequest.multiPart(request);
      var data = json.decode(await response.stream.bytesToString());

      log("${data}");
      if (data["status"] as bool) {
        User user = User.fromJson(data["data"]);
        onSuccess(user, data['message']);
      } else {
        onError(data['message']);
      }
    } catch (e) {
      log(e.toString());
      onError("Sorry! Something went wrong");
    }
  }
}

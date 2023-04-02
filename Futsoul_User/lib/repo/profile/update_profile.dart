import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:futsoul_user/models/user.dart';
import 'package:futsoul_user/utils/api.dart';
import 'package:futsoul_user/utils/storage_keys.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:futsoul_user/utils/http_request.dart';

class UpdateProfileRepo {
  static Future<void> updateProfile(
      {required String name,
      required String phone,
      File? image,
      required Function(User user, String message) onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": token.toString()
      };

      var url = Uri.parse(Api.updateProfileUrl);
      http.MultipartRequest request = http.MultipartRequest("POST", url);
      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      if (image != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            "image",
            await image.readAsBytes(),
            filename: "user",
            contentType: MediaType("image", "*"),
          ),
        );
      }
      http.StreamedResponse response = await HttpRequest.multiPart(request);
      var data = json.decode(await response.stream.bytesToString());
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

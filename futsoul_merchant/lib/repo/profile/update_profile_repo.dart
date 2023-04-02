import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:futsoul_merchant/models/user.dart';
import 'package:futsoul_merchant/utils/api.dart';
import 'package:futsoul_merchant/utils/storage_keys.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:futsoul_merchant/utils/http_request.dart';

class UpdateProfileRepo {
  static Future<void> updateProfile(
      {
      required String name,
      required String futsalName,
      required String phone,
      required String address,
      required String price,
      File? image,
      File? bannerImage,
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
      request.fields['futsal_name'] = futsalName;
      request.fields['phone'] = phone;
      request.fields['location'] = address;
      request.fields['price'] = price;
      if(image != null){
        request.files.add(
        http.MultipartFile.fromBytes(
          "image",
          await image.readAsBytes(),
          filename: "image",
          contentType: MediaType("image", "*"),
        ),
      );
      }
      if(bannerImage != null){
        request.files.add(
        http.MultipartFile.fromBytes(
          "banner",
          await bannerImage.readAsBytes(),
          filename: "banner",
          contentType: MediaType("image", "*"),
        ),
      );
      }
      
      http.StreamedResponse response = await HttpRequest.multiPart(request);
      var streamedData = await response.stream.bytesToString();
      log("Streamed data ====> ${streamedData}");
      var data = json.decode(streamedData);

      log("${data}");
      if (data["status"] as bool) {
        User user = User.fromJson(data["data"]);
        onSuccess(user, data['message']);
      } else {
        onError(data['message']);
      }
    } catch (e,s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! Something went wrong");
    }
  }
}

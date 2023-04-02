import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_user/models/banner.dart';
import 'package:futsoul_user/utils/api.dart';
import 'package:futsoul_user/utils/http_request.dart';
import 'package:futsoul_user/utils/storage_keys.dart';
import 'package:http/http.dart' as http;

class BannerRepo{

  static Future<void> getBanner({
    required Function(List<Banner> banners) onSuccess,
    required Function(String message) onError,
  }) async{

    try{

       var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      http.Response response = await HttpRequest.get(
        Uri.parse(Api.bannersUrl),
        headers: headers,
      );

      log("${Api.bannersUrl} ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if(data['status']){
        List<Banner> banners = bannersFromJson(data['data'] ['data']);
        onSuccess(banners);
      }else{
        onError(data['message']);
      }

    }catch(e,s){
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }

  }

}
import 'dart:convert';
import 'dart:developer';

import 'package:futsoul_merchant/utils/api.dart';
import 'package:futsoul_merchant/utils/http_request.dart';
import 'package:futsoul_merchant/utils/storage_keys.dart';
import 'package:http/http.dart' as http;

class IncomeRepo{

  static Future<void> getIncomes({
    required Function(double online, double offline) onSuccess,
    required Function(String message) onError,
  }) async{

    try{

       var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      http.Response response = await HttpRequest.get(
        Uri.parse(Api.incomesUrl),
        headers: headers,
      );

      log("${Api.incomesUrl} ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if(data['status']){
        int online = data['data']['online'];
        int offline = data['data']['offline'];
        onSuccess(online.toDouble(), offline.toDouble());
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
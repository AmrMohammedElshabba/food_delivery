import 'package:food_delivery/utlis/app_constants.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ApiClient extends  GetConnect implements GetxService{
 late String token;
 final String appBaseUrl;
 late Map <String,String> _mainHeaders;
 SharedPreferences sharedPreference;


  ApiClient({required this.appBaseUrl, required this.sharedPreference}){
    baseUrl = appBaseUrl;
    timeout= Duration(seconds: 30);
    token = sharedPreference.getString(AppConstants.token)??"";
    _mainHeaders= {
      'Content-type':'applicatin/json; charset=UTF-8',
      'Authorization':'Bearer $token'
    };
  }

  updateHeader(String token){
    _mainHeaders= {
      'Content-type':'applicatin/json; charset=UTF-8',
      'Authorization':'Bearer $token'
    };
  }

  Future<Response> getData(String url,{ Map<String, String>? headers}) async {
    try{
      Response response = await get(url,headers: headers??_mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postData(String url , dynamic body) async {
    try{
     Response response= await post(url, body, headers: _mainHeaders);
     return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

}
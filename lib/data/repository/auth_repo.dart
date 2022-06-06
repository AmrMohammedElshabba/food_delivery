import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/sign_up_body.dart';
import 'package:food_delivery/utlis/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/connect.dart';

class AuthRepo{

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient, required this.sharedPreferences
});

  Future<Response> registration(SignUpBody signUpBody){
    return apiClient.post(AppConstants.registerUri, signUpBody.toJson());
  }

  Future<Response> login(String phone, String password){
    return apiClient.post(AppConstants.loginUri, {"phone":phone,"password":password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token= token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.token)??"None";
  }

  bool userLoggedIn(){
    return  sharedPreferences.containsKey(AppConstants.token);
  }

  Future<void> saveUserPhoneAndPassword(String phone ,String password) async {
    try{
      await sharedPreferences.setString(AppConstants.phone, phone);
      await sharedPreferences.setString(AppConstants.password, password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.password);
    sharedPreferences.remove(AppConstants.phone);
    apiClient.token="";
    apiClient.updateHeader("");
    return true;
  }
}
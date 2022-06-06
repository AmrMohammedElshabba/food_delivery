import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utlis/app_constants.dart';
import 'package:get/get_connect/connect.dart';

class UserRepo{
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserData () async {
    return await apiClient.getData(AppConstants.userInfo);
  }
}
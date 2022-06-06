import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utlis/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList()async{
    return await apiClient.get(AppConstants.popularProductUri);
  }

}
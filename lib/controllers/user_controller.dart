import 'package:food_delivery/data/repository/user_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';

class UserController extends GetxController implements GetxService{

  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    _isLoading =true;
    update();
    Response response = await userRepo.getUserData();
    late ResponseModel responseModel;
    if(response.statusCode ==200){
      _userModel = UserModel.fromJson(response.body);
      responseModel =ResponseModel(true,"Successfully");
    }
    else{
      responseModel =ResponseModel(false,response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
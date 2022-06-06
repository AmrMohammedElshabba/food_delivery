import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductsModel> _recommendedProductList=[];
  List<ProductsModel> get recommendedProductList  => _recommendedProductList;

  bool _isLoading =true;
  bool  get isLoading => _isLoading;

  Future<void> getRecommendedProductList()async{
    Response response =await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200){
      print("Product dot");
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoading= false;
      update();
    }else{

    }
  }
}
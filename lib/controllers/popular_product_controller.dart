import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utlis/colors.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductsModel> _popularProductList = [];
  List<ProductsModel> get popularProductList => _popularProductList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("Product dot");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoading = false;
      update();
    } else {}
  }




  late CartController _cartController;

  int _quantity = 0;
  int get guantity => _quantity;

  int _inCartItem = 0;
  int get inCartItem => _quantity+_inCartItem;

  setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity+ 1);
    } else {
      _quantity = checkQuantity(_quantity- 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((quantity+_inCartItem)  < 0) {
      Get.snackbar("Item count", "You can't reduce more !",
          backgroundColor: KmainColor, colorText: Colors.black);
      if(_inCartItem>0){
        _quantity= -_inCartItem;
        return _quantity;
      }
      return 0;
    } else if ((quantity+_inCartItem)  > 20) {
      Get.snackbar("Item count", "You can't add more !",
          backgroundColor: KmainColor, colorText: Colors.black);
      return 20;
    } else
      return quantity;
  }


  void initProduct(ProductsModel product,CartController cartController){

    _quantity=0;
    _inCartItem =0;
    _cartController=cartController;
    var exist = false;
    exist=_cartController.existInCart(product);
    if(exist){
      _inCartItem =_cartController.getQuantity(product);
    }
    print(_inCartItem.toString());
  }

  void addItem(ProductsModel productsModel){
     _cartController.addItem(productsModel, _quantity);
     _quantity=0;
     _inCartItem=_cartController.getQuantity(productsModel);
      update();
  }

  int get totalItems{
    return _cartController.totalItems;
  }

  List<CartModel> get getItems{
    return _cartController.getItems;
  }
}

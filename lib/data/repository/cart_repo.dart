import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utlis/app_constants.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});


  List<String> cart =[];
List<String> cartHistory =[];

  void addToCartList(List<CartModel> cartList){
//     sharedPreferences.remove(AppConstants.cartHistoryList);
//     sharedPreferences.remove(AppConstants.cartList);
    var time = DateTime.now().toString();
    cart=[];

    /*
    convert object to string to store it in sharesPreferences
     */
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    
    sharedPreferences.setStringList(AppConstants.cartList, cart);
    // print(sharedPreferences.getStringList(AppConstants.cartList));
    //
    // getCartList();
  }
  List<CartModel> getCartList(){

    List<String> cart=[];

    if(sharedPreferences.containsKey(AppConstants.cartList)){
      cart = sharedPreferences.getStringList(AppConstants.cartList)!;
    }
    List<CartModel> cartList=[];
    cart.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }
  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.cartHistoryList)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    List<CartModel> cartHistoryList=[];
    cartHistory.forEach((element) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartHistoryList;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.cartHistoryList)){
      cartHistory = sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    for(int i = 0; i<cart.length ; i++){
      cartHistory.add(cart[i]);
      print(cart[i]);
    }
    sharedPreferences.setStringList(AppConstants.cartHistoryList, cartHistory);
    removeCart();
  }

  void removeCart() {
    cart=[];
    sharedPreferences.remove(AppConstants.cartList);
  }

  void clearCartHistory(){
    removeCart();
    sharedPreferences.remove(AppConstants.cartHistoryList);
    cartHistory =[];
    cart =[];
  }



}
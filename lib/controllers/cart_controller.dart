import 'package:food_delivery/utlis/colors.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get_core/src/get_main.dart';

class CartController extends GetxController {
  final CartRepo cartRebo;

  CartController({required this.cartRebo});

  Map<int, CartModel> _item = {};

  Map<int, CartModel> get item => _item;

  List<CartModel> storageItems =[];

  void addItem(ProductsModel product, int quantity) {
    var totalQuantity = 0;
    if (_item.containsKey(product.id)) {
      _item.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          quantity: value.quantity! + quantity,
          img: value.img,
          time: DateTime.now().toString(),
          isExist: true,
          products: product,
        );
      });
      if (totalQuantity <= 0) {
        _item.remove(product.id);
      }
      Get.snackbar("Go to cart", "This item updated in your cart",
          backgroundColor: KmainColor, colorText: Colors.black);
    } else {
      if (quantity > 0) {
        _item.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            quantity: quantity,
            img: product.img,
            time: DateTime.now().toString(),
            isExist: true,
            products: product,
          );
        });
        Get.snackbar("Go to cart", "This item added to your cart",
            backgroundColor: KmainColor, colorText: Colors.black);
      } else {
        Get.snackbar("Go to cart", "You should add at least one item",
            backgroundColor: KmainColor, colorText: Colors.black);
      }
    }
    cartRebo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductsModel product) {
    if (_item.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductsModel product) {
    var quantity = 0;
    if (_item.containsKey(product.id)) {
      _item.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _item.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _item.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount{
    var totalPrice = 0;
    _item.forEach((key, value) {
      totalPrice += value.quantity! * value.price! ;
    });
    return totalPrice;
  }
/*
get cart list from Sharedpreference and store it in _item Map
 */

  List<CartModel> getCartData(){
    setCart = cartRebo.getCartList();
    return storageItems;
  }

  set setCart  (List<CartModel> items){

    storageItems = items;
    for(int i=0; i<storageItems.length ; i++){
      _item.putIfAbsent(storageItems[i].products!.id!, () => storageItems[i]);
    }
  }

  void addToCartHistory(){
    cartRebo.addToCartHistoryList();
    _item={};
    update();
  }

  void clear(){
    _item ={};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRebo.getCartHistoryList();

  }

  void clearCartHistory(){
    cartRebo.clearCartHistory();
    update();
  }
//
//  set setItems(Map <int,CartModel> setItems){
//    _item={};
//    _item= setItems;
//  }
//
//  void addToCartList(){
//    cartRebo.addToCartList(getItems);
//    update();
//  }
}

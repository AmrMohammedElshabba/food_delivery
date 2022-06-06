import 'package:flutter/cupertino.dart';
import 'package:food_delivery/pages/auth/login_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_details.dart';
import 'package:food_delivery/pages/food/recommended_food_details.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_home_page.dart';
import 'package:food_delivery/pages/spalsh/splash_page.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class RouteHelper{
  static const String splash="/splash";
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage ="/cart-page";
  static const String signInPage ="/signIn-page";


  static String getSplashPage()=> "$splash";
  static String getInitialPage()=> "$initial";
  static String getPopularFood(int pageId,String cartpage)=> "$popularFood?pageId=$pageId&page=$cartpage";
  static String getRecommendedFood(int pageId,String cartpage)=> "$recommendedFood?pageId=$pageId&page=$cartpage";
  static String getCartPage()=> "$cartPage";
  static String getSignInPage()=> "$signInPage";




  static List<GetPage> routes=[
    GetPage(name: splash, page: ()=>SplashPage()),
    GetPage(name: initial, page: ()=>HomePage()),
    GetPage(name: signInPage, page: ()=>LoginPage()),
    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetails(pageId: int.parse(pageId!),page : page! );
    },
    transition: Transition.fadeIn
    ),

    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];

      return RecommendedFoodDetails(pageId: int.parse(pageId!),page : page! );
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: cartPage, page: (){
      return CartPage();
    },
        transition: Transition.fadeIn
    ),

  ];
}
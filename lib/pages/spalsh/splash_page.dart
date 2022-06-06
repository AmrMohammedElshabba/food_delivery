import 'dart:async';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utlis/colors.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadingResource() async {
   await Get.find<PopularProductController>().getPopularProductList();
   await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadingResource();
    controller = AnimationController(vsync: this,duration: const Duration(seconds: 2))..forward();
    animation= CurvedAnimation(
      parent: controller,
      curve: Curves.linear
    );
    Timer(
      const Duration(
        seconds: 3
      ),
        ()=>Get.offNamed(RouteHelper.getInitialPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,child: Center(
            child: Container(
                height: 200.h,
                width: 200.w,
                child: Image.asset("assets/images/logo.png",)),

          ),),
          Center(
            child: Text("The Best Food",style: Theme.of(context).textTheme.headline1!.copyWith(color: KmainColor,fontSize: 26),),
          )
        ],
      ),
    );
  }
}

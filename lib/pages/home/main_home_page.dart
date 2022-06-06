import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';

import 'package:food_delivery/utlis/colors.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  Future<void> _loadingResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column(
          children: [
            //Sowing the header
            Container(
                child: Container(
              padding: EdgeInsets.only(left: 20.h, right: 20.h),
              margin: EdgeInsets.only(top: 45.h, bottom: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Egypt",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: KmainColor),
                      ),
                      Row(
                        children: [
                          Text(
                            "City",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: KmainColor),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            //Sowing the body
            Expanded(
              child: SingleChildScrollView(child: FoodPageBody()),
            )
          ],
        ),
        onRefresh: _loadingResource);
  }
}

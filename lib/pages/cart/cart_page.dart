import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';

import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utlis/app_constants.dart';
import 'package:food_delivery/utlis/colors.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getInitialPage());
              },
              child: AppIcon(
                width: 40,
                height: 35,
                icon: Icons.arrow_back_ios,
                backgroundColor: KmainColor,
                iconsColor: Colors.white,
              ),
            ),
          ),
//          actions: [
//            Padding(
//              padding: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 20.w),
//              child: GestureDetector(
//                onTap: () {
//                  Get.toNamed(RouteHelper.getInitialPage());
//                },
//                child: AppIcon(
//                  icon: Icons.home_outlined,
//                  backgroundColor: KmainColor,
//                  iconsColor: Colors.white,
//                ),
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(
//                  top: 5.h, bottom: 5.h, left: 20.w, right: 20.w),
//              child: AppIcon(
//                icon: Icons.shopping_cart_outlined,
//                backgroundColor: KmainColor,
//                iconsColor: Colors.white,
//              ),
//            ),
//          ],
        ),
        body: Column(
          children: [
            GetBuilder<CartController>(
              builder: (cartController) {
                return cartController.getItems.length >0
                    ? Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w,
                                      right: 20.w,
                                      top: 5.h,
                                      bottom: 5.h),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .indexOf(cartController
                                                  .getItems[index].products!);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, "cartPage"));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(cartController
                                                    .getItems[index].products!);
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cartPage"));
                                          }
                                        },
                                        child: Container(
                                          height: 80.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.uploadUri +
                                                        cartController
                                                            .getItems[index]
                                                            .img!)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        padding: EdgeInsets.only(
                                            top: 5.h,
                                            bottom: 5.h,
                                            right: 10.w,
                                            left: 10.w),
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.r)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartController
                                                  .getItems[index].name
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                              maxLines: 1,
                                            ),
                                            Text(
                                              cartController.getItems[index].id
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                              maxLines: 1,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${cartController.getItems[index].price.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                        color: Colors.redAccent,
                                                      ),
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(
                                                              cartController
                                                                  .getItems[
                                                                      index]
                                                                  .products!,
                                                              -1);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 20.h,
                                                          color: Colors.black,
                                                        )),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                      cartController
                                                          .getItems[index]
                                                          .quantity
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1!
                                                          .copyWith(
                                                              fontSize: 20.sp),
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(
                                                              cartController
                                                                  .getItems[
                                                                      index]
                                                                  .products!,
                                                              1);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 20.h,
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 1.h,
                                ),
                            itemCount: cartController.getItems.length),
                      )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200.w,
                        height: 200.h,
                        child: Image.asset(
                          "assets/images/emptycart.png",
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "You didn't buy any thing yet",
                        style: Theme.of(context).textTheme.headline1,
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
          return cartController.getItems.isNotEmpty
              ? Container(
                  height: 100.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                      color: KbuttonBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        topLeft: Radius.circular(20.r),
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(20.0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                top: 15.h,
                                bottom: 15.h,
                                left: 15.w,
                                right: 15.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Text(
                              "Total price: \$${cartController.totalAmount}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 18.sp),
                            )),
                        GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              // print(Get.find<AuthController>().getUserToken());
                              cartController.addToCartHistory();
                            } else {
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 15.h,
                                  bottom: 15.h,
                                  left: 15.w,
                                  right: 15.h),
                              decoration: BoxDecoration(
                                  color: KmainColor,
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: Text(
                                "Check Out",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 18.sp),
                                maxLines: 1,
                              )),
                        )
                      ],
                    ),
                  ),
                )
              : Container();
        }));
  }
}

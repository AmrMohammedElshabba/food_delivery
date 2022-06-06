import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';

import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utlis/app_constants.dart';
import 'package:food_delivery/widget/app_column.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:food_delivery/widget/expandable_text_widget.dart';

import 'package:food_delivery/utlis/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PopularFoodDetails extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page=="cartPage"){
                        Get.toNamed(RouteHelper.getCartPage());

                      }else{
                        Get.toNamed(RouteHelper.getInitialPage());
                      }
                    },
                    child: AppIcon(
                      width: 40,
                      height: 35,
                      icon: Icons.arrow_back_ios,
                    ),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems >= 1){
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                              width: 40,
                              height: 35,
                              icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  top: 3.h,
                                  right: 0.w,
                                  child: Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      color: KmainColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                          controller.totalItems.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              ?.copyWith(
                                                color: Colors.black,
                                              )),
                                    ),
                                  ))
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: Container(
                  padding: EdgeInsets.only(top: 5.h, bottom: 10.h, left: 20.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                ),
              ),
              expandedHeight: 300.h,
              toolbarHeight: 70.h,
              automaticallyImplyLeading: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.uploadUri + product.img!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 20.h, right: 20.h, top: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.name!,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Introduce",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Container(
                      child: ExpandableTextWidget(text: product.description!),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
            builder: (popularProductController) {
          return Container(
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
                        top: 15.h, bottom: 15.h, left: 15.w, right: 15.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              popularProductController.setQuantity(false);
                            },
                            child: Icon(
                              Icons.remove,
                              size: 20.h,
                            )),
                        SizedBox(
                          width: 7.w,
                        ),
                        Text(
                          popularProductController.inCartItem.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 20.sp),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              popularProductController.setQuantity(true);
                            },
                            child: Icon(
                              Icons.add,
                              size: 20.h,
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProductController.addItem(product);
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 15.h, bottom: 15.h, left: 15.w, right: 15.h),
                        decoration: BoxDecoration(
                            color: KmainColor,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Text(
                          "\$${product.price.toString()} | To cart",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20.sp),
                          maxLines: 1,
                        )),
                  )
                ],
              ),
            ),
          );
        }));
  }
}

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/food/popular_food_details.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utlis/app_constants.dart';
import 'package:food_delivery/widget/app_column.dart';
import 'package:food_delivery/widget/icon_and_text_widget.dart';

import 'package:food_delivery/utlis/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: .85);
  var _cuurentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 200.h;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _cuurentPageValue = pageController.page!;
//        print(_cuurentPageValue);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Popular Food
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoading
                ? const CircularProgressIndicator(
                    color: KmainColor,
                  )
                : Container(
                    height: 300.h,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: popularProducts.popularProductList.length,
                        itemBuilder: (context, position) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getPopularFood(position,"home"));
                            },
                            child: _buildPageItem(position, context,
                                popularProducts.popularProductList[position]),
                          );
                        }),
                  );
          },
        ),
        // dots indicator
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _cuurentPageValue,
            decorator: DotsDecorator(
              activeColor: KmainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: 20.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Recommeneded",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
        //showing recommeneded food images and name
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProductController) {
          return recommendedProductController.isLoading
              ? const CircularProgressIndicator(
                  color: KmainColor,
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProductController
                      .recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20.h, right: 20.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.uploadUri +
                                        recommendedProductController
                                            .recommendedProductList[index].img!)),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.h),
                                child: AppColumn(
                                  text: recommendedProductController
                                      .recommendedProductList[index].name!,
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  });
        })
      ],
    );
  }

  Widget _buildPageItem(
      int index, BuildContext context, ProductsModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _cuurentPageValue.floor()) {
      var currScale = 1 - (_cuurentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _cuurentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_cuurentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _cuurentPageValue.floor() - 1) {
      var currScale = 1 - (_cuurentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: 210.h,
            margin: EdgeInsets.only(left: 10.h, right: 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.uploadUri + popularProduct.img!))),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              height: 120.h,
              margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 30.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    left: 15.h, right: 15.h, top: 15.h, bottom: 15.h),
                child: AppColumn(
                  text: popularProduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

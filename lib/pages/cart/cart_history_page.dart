import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utlis/app_constants.dart';
import 'package:food_delivery/utlis/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> getItemPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (getItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        getItemPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        getItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemPerOrderToList() {
      return getItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return getItemPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemPerOrderToList();

    var listCounter = 0;

    return Scaffold(
      appBar: AppBar(title: Text("Cart history",style: Theme.of(context).textTheme.headline1!.copyWith(color: KmainColor),),),
      body: Column(
        children: [
          GetBuilder<CartController>(builder: (_cartController) {
            var cartLenght = _cartController.getCartHistoryList();
            return cartLenght.isNotEmpty
                ? Expanded(
                    child: ListView(
                      children: [
                        for (int i = 0; i < itemsPerOrder.length; i++)
                          Container(
                            padding: EdgeInsets.only(
                                top: 20.h, left: 20.w, right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (() {
                                  DateTime parseDate =
                                      DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                          getCartHistoryList[listCounter]
                                              .time!);
                                  var inputDate =
                                      DateTime.parse(parseDate.toString());
                                  var outputFormat =
                                      DateFormat("MM/dd/yyyy hh:mm a");
                                  var outputDate =
                                      outputFormat.format(inputDate);
                                  return Text(
                                    outputDate,
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  );
                                }()),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      children: List.generate(itemsPerOrder[i],
                                          (index) {
                                        if (listCounter <
                                            getCartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                                height: 70.h,
                                                width: 70.w,
                                                margin:
                                                    EdgeInsets.only(right: 5.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            AppConstants
                                                                    .uploadUri +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!))),
                                              )
                                            : Container();
                                      }),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Total",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                          Text("${itemsPerOrder[i]} Items",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1),
                                          GestureDetector(
                                            onTap: () {
                                              var orderTime =
                                                  cartOrderTimeToList();
                                              Map<int, CartModel> moreOrder =
                                                  {};
                                              for (int j = 0;
                                                  j < getCartHistoryList.length;
                                                  j++) {
                                                if (getCartHistoryList[j]
                                                        .time ==
                                                    orderTime[i]) {
                                                  moreOrder.putIfAbsent(
                                                      getCartHistoryList[j].id!,
                                                      () => CartModel.fromJson(
                                                          jsonDecode(jsonEncode(
                                                              getCartHistoryList[
                                                                  j]))));
                                                }
                                              }
//                                      Get.find<CartController>().setItems =
//                                          moreOrder;
//                                      Get.find<CartController>()
//                                          .addToCartList();
//                                      Get.toNamed(RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h,
                                                  horizontal: 5.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: KmainColor)),
                                              child: Text(
                                                "one more",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        color: KmainColor),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
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
          })
        ],
      ),
    );
  }
}

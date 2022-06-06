import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utlis/colors.dart';
import 'package:food_delivery/widget/app_icon.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _userLoginIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoginIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: KmainColor),
          ),
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (controller) {
          return _userLoginIn
              ? (controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Container(
                          width: 125.w,
                          height: 110.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: KmainColor,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 70.h,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CartDetails(
                                    context, Icons.person, KmainColor, controller.userModel.name),
                                CartDetails(context, Icons.phone, KiconColor1,
                                    controller.userModel.phone),
                                CartDetails(context, Icons.mail, KiconColor1,
                                    controller.userModel.email),
                                CartDetails(context, Icons.location_on,
                                    KiconColor1, "mansoura"),
                                CartDetails(context, Icons.message, Colors.red,
                                    "Message"),
                                GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.find<CartController>().clear();
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      } else {
                                        Get.snackbar(
                                            "Wait", "You are not login yet",
                                            backgroundColor: KmainColor,
                                            colorText: Colors.black);
                                      }
                                    },
                                    child: CartDetails(context, Icons.logout,
                                        Colors.red, "Logout")),
                                SizedBox(
                                  height: 10.h,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ))
              : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200.h,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/bicycle.png")
                          )
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getSignInPage());
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                          child: Container(
                            height: 100.h,
                            width: double.maxFinite,
                            decoration:  BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                              color: KmainColor
                            ),
                            child: Center(child: Text("Sign in",style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white,fontSize: 30.sp),)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
        },
      ),
    );
  }

  Widget CartDetails(BuildContext context, IconData icon, Color backgroundColor,
      String title) {
    return Card(
      child: Container(
        height: 60.h,
        width: double.maxFinite,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: AppIcon(
                icon: icon,
                height: 40,
                width: 45,
                backgroundColor: backgroundColor,
                iconsColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Text(
              title,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(overflow: TextOverflow.ellipsis),
            ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/base/show_custom_snackebar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utlis/colors.dart';
import 'package:food_delivery/widget/custom_text_form.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passController = TextEditingController();
    var phoneController = TextEditingController();

    void _login(AuthController authController) {
      String password = passController.text.trim();
      String phone = phoneController.text.trim();

      if (phone.isEmpty) {
        customSnackBar("Phone field is empty");
      } else if (password.isEmpty) {
        customSnackBar("Password field is empty");
      } else if (password.length < 6) {
        customSnackBar("Password can't be less than six characters");
      } else {

        authController.login(phone,password).then((state) {
          if (state.isSuccess) {
            Get.toNamed(RouteHelper.getInitialPage());
          } else {
            customSnackBar(state.message);
          }
        });
      }
    }
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (authController) {
          return  authController.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 100.h,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/logo.png"),
                      radius: 50.r,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 36.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Sign into your account",
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextForm(
                  hint: 'Phone',
                  prefixIcon: Icons.phone,
                  controller: phoneController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextForm(
                  hint: 'Password',
                  isObsecure: true,
                  prefixIcon: Icons.lock,
                  controller: passController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: KmainColor,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      _login(authController);
                    },
                    child: Center(
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Sign into your account",
                              style: Theme.of(context).textTheme.subtitle1)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.subtitle1,
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage()),
                          text: "Create",
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ]),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          );
        },),
      )
    );
  }
}

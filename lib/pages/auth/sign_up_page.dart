import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/base/show_custom_snackebar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/sign_up_body.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utlis/colors.dart';
import 'package:food_delivery/widget/custom_text_form.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["f.png", "g.png", "t.png"];

    void _registration(AuthController authController) {
      String email = emailController.text.trim();
      String password = passController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      if (email.isEmpty) {
        customSnackBar("Email field is empty");
      } else if (!GetUtils.isEmail(email)) {
        customSnackBar("Invalid email");
      } else if (password.isEmpty) {
        customSnackBar("Password field is empty");
      } else if (password.length < 6) {
        customSnackBar("Password can't be less than six characters");
      } else if (name.isEmpty) {
        customSnackBar("Name field is empty");
      } else if (phone.isEmpty) {
        customSnackBar("Phone field is empty");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, email: email, phone: phone, password: password);
        authController.registration(signUpBody).then((state) {
          if (state.isSuccess) {
            Get.toNamed(RouteHelper.getInitialPage());
          } else {
            customSnackBar(state.message);
          }
        });
      }
    }

    return Scaffold(
      body: SafeArea(child: GetBuilder<AuthController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 100.h,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/logo.png"),
                            radius: 50.r,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextForm(
                        hint: 'Email',
                        prefixIcon: Icons.email,
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextForm(
                        hint: 'Password',
                        prefixIcon: Icons.lock,
                        isObsecure: true,
                        controller: passController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextForm(
                        hint: 'Name',
                        prefixIcon: Icons.person,
                        controller: nameController,
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
                      GestureDetector(
                        onTap: () {
                          _registration(controller);
                        },
                        child: Container(
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: KmainColor,
                          ),
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
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Have an account already?",
                              style: Theme.of(context).textTheme.subtitle1)),
                      SizedBox(
                        height: 20.h,
                      ),
                      RichText(
                          text: TextSpan(
                              text:
                                  "Sign Up using one of the following methods",
                              style: Theme.of(context).textTheme.subtitle1)),
                      SizedBox(
                        height: 20.h,
                      ),
                      Wrap(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0.h),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/" + signUpImages[index]),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                );
        },
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/auth/login_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utlis/themes.dart';
import 'package:get/get.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependences.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return ScreenUtilInit(
            designSize: Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                // Use this line to prevent extra rebuilds
                useInheritedMediaQuery: true,
                title: 'Food Delivery',
                // You can use the library anywhere in the app even in theme
                theme: Themes.lightTheme,
                // home: LoginPage(),
                initialRoute: RouteHelper.getSplashPage(),
                getPages: RouteHelper.routes,
              );
            },
          );
        });
      },
    );
  }
}

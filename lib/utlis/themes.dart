import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/utlis/colors.dart';

class Themes{
  static final lightTheme = ThemeData(
      primarySwatch: Colors.grey,
//      scaffoldBackgroundColor: Colors.white,
      appBarTheme:  AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
          ),
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: KiconColor1),
      textTheme: ThemeData.light().textTheme.copyWith(
        headline1: TextStyle(fontSize: 22.sp, color: KmainBlackColor,fontWeight: FontWeight.w400),
        subtitle1: TextStyle(fontSize: 16.sp,color: KsignColor),
        subtitle2: TextStyle(fontSize: 12.sp,color: KsignColor),
//        bodyText1: TextStyle(
//            fontSize: 16.0,
//            color: Colors.black
//        ),
//        bodyText2: TextStyle(
//          fontSize: 15,
//          color: Colors.grey,
//        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 100.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: KmainColor,
          unselectedItemColor: Colors.amberAccent));

  static final darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      canvasColor: Colors.white30,
      backgroundColor: Colors.white30,
      appBarTheme:  AppBarTheme(
          color: Colors.white30,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(
            color: Colors.white,
          )),
      iconTheme: const IconThemeData(color: KiconColor1),
      textTheme: ThemeData.dark().textTheme.copyWith(
        headline1: TextStyle(fontSize: 22.sp, color: Colors.white,fontWeight: FontWeight.w400),
        subtitle1: TextStyle(fontSize: 16.sp,color: KsignColor),
        subtitle2: TextStyle(fontSize: 12.sp,color: KsignColor),
//        bodyText1: TextStyle(
//            fontSize: 16.0,
//            color: Colors.white
//        ),
//        bodyText2: TextStyle(
//          fontSize: 15,
//          color: Colors.grey,
//        ),
      ),
      cardColor: Colors.white10,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white10,
          elevation: 100.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor:  KmainColor,
          unselectedItemColor: Colors.amberAccent));

}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
   final Color? backgroundColor;
  final Color? iconsColor;
  final double height;
  final double width;
   const AppIcon({Key? key, required this.icon, this.backgroundColor, this.iconsColor, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w ,
      height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50/2),
        color: backgroundColor ?? Color(0xFFfcf4e4),
      ),
      child: Icon(icon,size: 16.h,color: iconsColor ?? Color(0xFF756d54),),
    );
  }
}

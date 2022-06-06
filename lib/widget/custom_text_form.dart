import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:food_delivery/utlis/colors.dart';

class CustomTextForm extends StatelessWidget {
   CustomTextForm(
      {Key? key,
      required this.hint,
        this.isObsecure,
      required this.prefixIcon,
      required this.controller})
      : super(key: key);
  final String hint;
  bool? isObsecure;
  final IconData prefixIcon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w,),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  spreadRadius: 7,
                  blurRadius: 3,
                  offset: Offset(2, 3))
            ]),
        child: TextField(
          controller: controller,
          obscureText: isObsecure?? false,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              prefixIcon,
              color: KmainColor,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
          ),
        ),
      ),
    );
  }
}

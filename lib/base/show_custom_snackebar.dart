import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar(String message) {
  Get.snackbar("Error", message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white);
}

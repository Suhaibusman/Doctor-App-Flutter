import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController{


  Rx<bool> isSwitched = false.obs;

  void setIsSwitched(bool value) {
    isSwitched.value = value;
    if (isSwitched.isTrue) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }
}
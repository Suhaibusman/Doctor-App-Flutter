import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString currentLanguage = 'en_US'.obs;

  void changeLanguage() {
    if (currentLanguage == 'en_US') {
      currentLanguage.value = 'ur_PK';
         Get.updateLocale( const Locale("ur", "PK"));
    } else {
      currentLanguage.value = 'en_US';
     Get.updateLocale(const Locale("en", "US"));
    }
  }


}
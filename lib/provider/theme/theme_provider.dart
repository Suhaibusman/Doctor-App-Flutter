import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
   ThemeData _themeMode =ThemeData.light();
 ThemeData get themeMode => _themeMode;

 void toogleTheme(){
  final isLight =_themeMode == ThemeData.light();
   if (isLight) {
      _themeMode =ThemeData.dark();
   
   }else{
    _themeMode =ThemeData.light();
    
   }
   notifyListeners();
  }
}
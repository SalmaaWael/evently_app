import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode currentTheme=ThemeMode.light;
  String currentLanguage="en";
  void changeAppTheme(ThemeMode newTheme){
    if(currentTheme==newTheme) return;
    currentTheme=newTheme;
    notifyListeners();
  }

  bool get isDark=>currentTheme==ThemeMode.dark;



}
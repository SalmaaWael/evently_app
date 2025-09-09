import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  String currentLanguage="en";
  bool get isEnglish=>currentLanguage=="en";
  void changeAppLang(String newLang){
    if(currentLanguage==newLang) return;
    currentLanguage=newLang;
    notifyListeners();
  }
}
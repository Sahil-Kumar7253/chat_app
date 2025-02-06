import 'package:chat_app1/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme (){
    _themeData = (_themeData == lightMode) ? darkMode : lightMode;
    notifyListeners();
  }
}

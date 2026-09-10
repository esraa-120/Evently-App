import 'package:flutter/material.dart';

class SettingsConfig extends ChangeNotifier {

  ThemeMode currentTheme = ThemeMode.light;
  void changeCurrentTheme(ThemeMode newThemeMode){

    if(newThemeMode == currentTheme) return;
    currentTheme = newThemeMode;
    notifyListeners();
  }
  bool isDarkMode() => currentTheme == ThemeMode.dark;
}
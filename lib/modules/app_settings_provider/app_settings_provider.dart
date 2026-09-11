import 'package:evently_app/modules/layout/favorite/favorite_view.dart';
import 'package:evently_app/modules/layout/home/home_view.dart';
import 'package:evently_app/modules/layout/profile/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSettingsProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int _currentCategoryIndex = 0;
  String currentLanguage = "en";
  ThemeMode currentTheme = ThemeMode.light;

  int get currentIndex => _currentIndex;

  int get currentCategoryIndex => _currentCategoryIndex;

  List<Widget> get pages => [HomeView(), ProfileView(), FavoriteView()];

  String get currentTextLanguage=> currentLanguage == "en" ? "En" : "Ar";

  void changeCurrentCategoryIndex(int index) {
    _currentCategoryIndex = index;
    notifyListeners();
  }

  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    currentLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    currentTheme = newTheme;
    notifyListeners();
  }

  bool isDarkTheme() => currentTheme == ThemeMode.dark;
}
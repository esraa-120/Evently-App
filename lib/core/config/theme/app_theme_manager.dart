import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

abstract class AppThemeManager {
  static ThemeData getLightTheme() => ThemeData(
    primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          color: AppColors.mainText,
          fontWeight: FontWeight.w500,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          color: AppColors.mainText,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.mainText,
        fontWeight: FontWeight.w400,
      ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.secondaryText,
          fontWeight: FontWeight.w400,
        ),
    ),
  );
  static ThemeData getDarkTheme() => ThemeData(
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
  ),
    textTheme: TextTheme(
    headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: AppColors.secondaryTextDark,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.secondaryTextDark,
        fontWeight: FontWeight.w400,
      ),
    bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.secondaryTextDark,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
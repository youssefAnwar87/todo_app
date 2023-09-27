import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/UI/utils/app_colors.dart';

abstract class AppTheme{
  static TextStyle appBarTextStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: AppColors.white);
  static TextStyle taskTitleTextStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: AppColors.primary);
  static TextStyle taskDiscriptionTextStyle = TextStyle(fontWeight: FontWeight.normal,fontSize: 14,color: AppColors.lightBlack);
  static TextStyle bottomSheetTitleTextStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColors.black);
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    appBarTheme:  AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: appBarTextStyle,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(size: 32),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
    ),
    scaffoldBackgroundColor: AppColors.accent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.white,width: 4),
      )
    )
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    appBarTheme:  AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      elevation: 0,
      titleTextStyle: appBarTextStyle.copyWith(color: AppColors.accentDark),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(size: 32),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.accentDark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.accentDark,width: 4),
      )
    )
  );
}
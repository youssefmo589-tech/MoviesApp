import 'package:flutter/material.dart';

import 'AppColors.dart';

abstract class AppThemeManager {
  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: AppColors.white
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.white
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.white
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.white
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white
      ),


    ),
  );
}

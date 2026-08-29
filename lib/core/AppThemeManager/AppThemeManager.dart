import 'package:flutter/material.dart';

import 'AppColors.dart';

abstract class AppThemeManager {
  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    ),
  );
}

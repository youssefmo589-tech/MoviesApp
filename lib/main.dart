import 'package:flutter/material.dart';
import 'package:movieapp/core/AppRoutes/AppRouteConfig.dart';

import 'core/AppRoutes/AppRouteName.dart';
import 'core/AppThemeManager/AppThemeManager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteName.Profile,
      onGenerateRoute: AppConfig.onGenerateRoute,
      theme: AppThemeManager.theme,
    );
  }
}

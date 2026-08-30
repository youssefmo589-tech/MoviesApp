import 'package:flutter/material.dart';
import 'package:movieapp/core/AppRoutes/AppRouteConfig.dart';

import 'core/AppRoutes/AppRouteName.dart';
import 'core/AppThemeManager/AppThemeManager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteName.login,
      onGenerateRoute: AppConfig.onGenerateRoute,
      theme: AppThemeManager.theme,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movieapp/core/AppRoutes/app_route_config.dart';

import 'core/AppRoutes/app_route_name.dart';
import 'core/AppThemeManager/app_theme_manager.dart';

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

import 'package:flutter/material.dart';

import 'core/app_routes/app_route_config.dart';
import 'core/app_routes/app_route_name.dart';
import 'core/app_theme_manager/app_theme_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteName.profile,
      onGenerateRoute: AppConfig.onGenerateRoute,
      theme: AppThemeManager.theme,
    );
  }
}

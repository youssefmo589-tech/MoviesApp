import 'package:flutter/material.dart';
import 'core/AppRoutes/AppRouteConfig.dart';
import 'core/AppRoutes/AppRouteName.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteName.Initial,
      onGenerateRoute: AppConfig.onGenerateRoute,
    );
  }
}

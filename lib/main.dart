import 'package:flutter/material.dart';
import 'package:movieapp/core/AppRoutes/AppRouteConfig.dart';

import 'core/AppRoutes/AppRouteName.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRouteName.Initial,
      onGenerateRoute: AppConfig.onGenerateRoute,
    );
  }
}

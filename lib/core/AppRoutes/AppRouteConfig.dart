import 'package:flutter/material.dart';
import '../../Models/Home/Home.dart';
import '../../Models/splashScreen/SplashScreen.dart';
import 'AppRouteName.dart';

abstract class AppConfig {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.Initial:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRouteName.Home:
        return MaterialPageRoute(builder: (context) => Home());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:movieapp/Models/Authentication/presentation/ForgetPassword/forgetPassword.dart';
import 'package:movieapp/Models/Home/Home.dart';
import 'package:movieapp/Models/splashScreen/SplashScreen.dart';

import 'AppRouteName.dart';

abstract class AppConfig {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.Initial:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRouteName.Home:
        return MaterialPageRoute(builder: (context) => Home());

      case AppRouteName.ForgetPassword:
        return MaterialPageRoute(builder: (context) => Forgetpassword());
    }
  }
}

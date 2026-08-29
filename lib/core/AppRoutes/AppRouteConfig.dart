import 'package:flutter/material.dart';
import 'package:movieapp/Models/Home/Home.dart';
import 'package:movieapp/Models/splashScreen/SplashScreen.dart';

import '../../Models/Authentication/presentation/ForgetPasswordUI/forgetPassword.dart';
import '../../Models/ProfilePage/Profile.dart';
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

      case AppRouteName.Profile:
        return MaterialPageRoute(builder: (context) => Profile());
    }
  }
}

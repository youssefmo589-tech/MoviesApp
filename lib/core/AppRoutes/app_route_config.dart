import 'package:flutter/material.dart';
import '../../modules/Authentication/presentation/ForgetPasswordUI/forgetPassword.dart';
import '../../modules/Authentication/presentation/login_screen.dart';
import '../../modules/Authentication/presentation/register_screen.dart';
import '../../modules/Home/home_screen.dart';
import '../../modules/ProfilePage/profile_screen.dart';
import '../../modules/splashScreen/splash_screen.dart';
import 'app_route_name.dart';

abstract class AppConfig {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.initial:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRouteName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case AppRouteName.forgetPassword:
        return MaterialPageRoute(builder: (context) => Forgetpassword());

      case AppRouteName.profile:
        return MaterialPageRoute(builder: (context) => Profile());

      case AppRouteName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case AppRouteName.register:
        return MaterialPageRoute(builder: (context) => RegisterScreen());

      default:
        return null;
    }
  }
}

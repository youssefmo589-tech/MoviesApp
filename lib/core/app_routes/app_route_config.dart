import 'package:flutter/material.dart';
import '../../modules/Home/home_screen.dart';
import '../../modules/auth/presentation/forget_password.dart';
import '../../modules/auth/presentation/login_screen.dart';
import '../../modules/auth/presentation/register_screen.dart';
import '../../modules/onboarding/on_boarding_screen.dart';
import '../../modules/profile/presentation/profile_screen.dart';
import '../../modules/splash/splash_screen.dart';
import 'app_route_name.dart';

abstract class AppConfig {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.initial:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRouteName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case AppRouteName.onBoarding:
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());

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

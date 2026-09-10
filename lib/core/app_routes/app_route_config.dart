import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/auth/presentation/manager/auth_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/pages/profile/presentation/home_screen.dart';

import '../../modules/auth/presentation/screens/forget_password.dart';
import '../../modules/auth/presentation/screens/login_screen.dart';
import '../../modules/auth/presentation/screens/register_screen.dart';
import '../../modules/layoutviewFeature/presentation/manager/editProfileBloc.dart';
import '../../modules/layoutviewFeature/presentation/pages/profile/presentation/Editprofile_screen.dart';
import '../../modules/onboarding/on_boarding_screen.dart';
import '../../modules/splash/splash_screen.dart';
import 'app_route_name.dart';

abstract class AppConfig {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.initial:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRouteName.onBoarding:
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());

      case AppRouteName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case AppRouteName.Editprofile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
            child: EditProfile(),
          ),
        );

      case AppRouteName.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc.withDefaultDependencies(),
            child: LoginScreen(),
          ),
        );

      case AppRouteName.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc.withDefaultDependencies(),
            child: Forgetpassword(),
          ),
        );

      case AppRouteName.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc.withDefaultDependencies(),
            child: RegisterScreen(),
          ),
        );

      default:
        return null;
    }
  }
}

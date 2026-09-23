import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/SharedPrefService/SharedPrefService.dart';
import '../../core/app_routes/app_route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeSplash();
  }

  Future<void> initializeSplash() async
  {
    await checkOnBoarding();
  }

  Future<void> checkOnBoarding() async
  {
    final user = FirebaseAuth.instance.currentUser;
    final isseen = await SharedPrefService.getPref();
    if (isseen) {
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRouteName.home, (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRouteName.login, (route) => false);
      }
    }
    else {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRouteName.onBoarding, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/splash_screen.png',
              width: 253,
              height: 253,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Image.asset(
                'assets/images/splash_route.png',
                width: 180,
                height: 76,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
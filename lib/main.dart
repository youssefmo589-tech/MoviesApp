import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/app_routes/app_route_config.dart';
import 'package:movieapp/core/app_routes/app_route_name.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/pages/profile/presentation/home_screen.dart';
import 'core/app_theme_manager/app_theme_manager.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteName.initial,
      onGenerateRoute: AppConfig.onGenerateRoute,
      theme: AppThemeManager.theme,
    );
  }
}

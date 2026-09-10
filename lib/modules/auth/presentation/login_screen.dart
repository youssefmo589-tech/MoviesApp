import 'package:flutter/material.dart';

import '../../../core/app_routes/app_route_name.dart';
import '../../../core/app_theme_manager/app_colors.dart';
import '../../../core/gen/assets.gen.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/language_selector_widget.dart';
import '../../../widgets/text_form_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Assets.images.logo.image(),
                SizedBox(height: 69),
                TextFormFieldWidget(
                  hintText: "Email",
                  prefixIcon: Assets.icons.emailIcon.svg(),
                ),
                SizedBox(height: 22),
                TextFormFieldWidget(
                  hintText: "Password",
                  prefixIcon: Assets.icons.password.svg(),
                  isPassword: true,
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRouteName.forgetPassword);
                      },
                      child: Text(
                        "Forget Password?",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 34),
                ButtonWidget(
                  title: "Login",
                  buttoncolor: AppColors.yellow,
                  titlecolor: AppColors.black,
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteName.home);
                  },
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t Have Account ?",
                      style: theme.textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteName.register);
                      },
                      child: Text(
                        " Create One",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.yellow,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.yellow,
                        indent: 65,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      "OR",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.yellow,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.yellow,
                        indent: 10,
                        endIndent: 65,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28),
                ButtonWidget(
                  title: 'Login With Google',
                  buttoncolor: AppColors.yellow,
                  titlecolor: AppColors.black,
                  icon: Assets.icons.google.svg(),
                ),
                SizedBox(height: 33),
                LanguageSelectorWidget(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

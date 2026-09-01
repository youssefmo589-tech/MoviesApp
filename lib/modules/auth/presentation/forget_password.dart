import 'package:flutter/material.dart';

import '../../../core/app_routes/app_route_name.dart';
import '../../../core/app_theme_manager/app_colors.dart';
import '../../../core/gen/assets.gen.dart';
import '../../../widgets/button_widget.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColors.yellow, size: 24),
        ),
        title: Text(
          "Forget Password",
          style: theme.titleSmall?.copyWith(color: AppColors.yellow),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 24,
            children: [
              Assets.images.forgotPasswordBro1.image(),

              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 16,
                    ),
                    hintText: "Email",
                    hintStyle: theme.titleSmall?.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.white,
                      size: 31,
                    ),
                    filled: true,
                    fillColor: AppColors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              ButtonWidget(title: "Verify Email",
                  buttoncolor: AppColors.yellow,
                  titlecolor: AppColors.black,
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteName.profile);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

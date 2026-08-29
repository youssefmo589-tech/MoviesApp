import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/AppThemeManager/AppColors.dart';
import '../../../../core/gen/assets.gen.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

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

              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 55.72218704223633,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Verify Email",
                      style: theme.titleSmall?.copyWith(
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

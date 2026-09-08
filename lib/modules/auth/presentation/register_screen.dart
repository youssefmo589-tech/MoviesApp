import 'package:flutter/material.dart';

import '../../../core/app_routes/app_route_name.dart';
import '../../../core/app_theme_manager/app_colors.dart';
import '../../../core/gen/assets.gen.dart';
import '../../../widgets/arrow_back_widget.dart';
import '../../../widgets/avatars_carousel_slider_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/language_selector_widget.dart';
import '../../../widgets/text_form_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackWidget(),
        title: Text(
          "Register",
          style: theme.bodyLarge?.copyWith(
            color: AppColors.yellow,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            AvatarsCarouselSliderWidget(),
            SizedBox(height: 10),
            Center(child: Text("Avatar")),
            SizedBox(height: 12),
            Column(
              spacing: 24,
              children: [
                TextFormFieldWidget(hintText:"Name", prefixIcon: Assets.icons.name.svg(),),
                TextFormFieldWidget(hintText:"Email", prefixIcon: Assets.icons.emailIcon.svg(),),
                TextFormFieldWidget(hintText:"Password", isPassword: true,prefixIcon: Assets.icons.password.svg()),
                TextFormFieldWidget(hintText:"Confirm Password", isPassword: true,prefixIcon: Assets.icons.password.svg()),
                TextFormFieldWidget(hintText:"Phone Number", prefixIcon: Assets.icons.phone.svg(),),
                ButtonWidget(title: "Create Account", buttoncolor: AppColors.yellow, titlecolor: AppColors.black, onTap: (){
                  Navigator.pushNamed(context, AppRouteName.login);
                }),
              ],
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have Account ?",
                  style: theme.bodyMedium,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteName.login);
                  },
                  child: Text(
                    " Login",
                    style: theme.bodyMedium?.copyWith(
                      color: AppColors.yellow,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            LanguageSelectorWidget(),
          ],
        ),
      )
    );
  }
}

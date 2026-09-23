import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movieapp/modules/auth/domain/entity/user_entity.dart';
import 'package:movieapp/modules/auth/presentation/screens/register_screen.dart';

import '../../../../core/Services/BotToastservice.dart';
import '../../../../core/app_routes/app_route_name.dart';
import '../../../../core/app_theme_manager/app_colors.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/language_selector_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';
import '../manager/auth_bloc.dart';
import '../manager/auth_event.dart';
import '../manager/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          EasyLoading.show();
        }

        if (state is AuthSuccessSignInWithGoogle) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(
              context, AppRouteName.home, (route) => false);
        }
        if (state is AuthNewGoogleUser) {
          EasyLoading.dismiss();
          final user = state.credential.user;
          if (user == null) {
            return;
          }
          final userentity = UserEntity(uid: user!.uid,
              email: user.email ?? '',
              name: user.displayName ?? '',
              phone: user.phoneNumber ?? '');
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => RegisterScreen(),
              settings: RouteSettings(arguments: userentity)));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: SingleChildScrollView(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    AppSnackBar.error(state.message);
                  } else if (state is AuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRouteName.home, (route) => false);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Assets.images.logo.image(),
                        SizedBox(height: 69),
                        TextFormFieldWidget(
                          hintText: "Email",
                          prefixIcon: Assets.icons.emailIcon.svg(),
                          controller: emailController,
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) return "Please enter your email";
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(email)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 22),
                        TextFormFieldWidget(
                          hintText: "Password",
                          prefixIcon: Assets.icons.password.svg(),
                          isPassword: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
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
                          onTap: isLoading ? null : () => _submit(context),
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
                                Navigator.pushNamed(
                                    context, AppRouteName.register);
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
                          onTap: () {
                            context.read<AuthBloc>().add(
                                SignInWithGoogleEvent());
                          },
                        ),
                        SizedBox(height: 33),
                        LanguageSelectorWidget(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
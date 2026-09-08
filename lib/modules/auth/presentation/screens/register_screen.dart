import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Services/BotToastservice.dart';
import '../../../../core/app_routes/app_route_name.dart';
import '../../../../core/app_theme_manager/app_colors.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../widgets/arrow_back_widget.dart';
import '../../../../widgets/avatars_carousel_slider_widget.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/language_selector_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';
import '../manager/auth_bloc.dart';
import '../manager/auth_event.dart';
import '../manager/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        RegisterRequested(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          phone: phoneController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackWidget(),
        title: Text(
          "Register",
          style: theme.bodyLarge?.copyWith(color: AppColors.yellow),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                AppSnackBar.error(state.message);
              } else if (state is AuthSuccess) {
                AppSnackBar.success("Account created! Please log in.");
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRouteName.login, (route) => false);
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    AvatarsCarouselSliderWidget(),
                    SizedBox(height: 10),
                    Center(child: Text("Avatar")),
                    SizedBox(height: 12),
                    Column(
                      spacing: 24,
                      children: [
                        TextFormFieldWidget(
                          hintText: "Name",
                          prefixIcon: Assets.icons.name.svg(),
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          hintText: "Email",
                          prefixIcon: Assets.icons.emailIcon.svg(),
                          controller: emailController,
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(email)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          hintText: "Password",
                          isPassword: true,
                          prefixIcon: Assets.icons.password.svg(),
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          hintText: "Confirm Password",
                          isPassword: true,
                          prefixIcon: Assets.icons.password.svg(),
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          hintText: "Phone Number",
                          prefixIcon: Assets.icons.phone.svg(),
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your phone number";
                            }
                            return null;
                          },
                        ),
                        ButtonWidget(
                          title: isLoading ? "Please wait..." : "Create Account",
                          buttoncolor: AppColors.yellow,
                          titlecolor: AppColors.black,
                          onTap: isLoading ? null : () => _submit(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already Have Account ?", style: theme.bodyMedium),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
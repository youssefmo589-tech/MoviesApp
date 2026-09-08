import 'package:flutter/material.dart';

import '../core/app_theme_manager/app_colors.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int maxLines;

  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.suffixIcon,
    this.maxLines = 1, this.validator, this.controller,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isObSecure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.maxLines,
      obscureText: widget.isPassword ? isObSecure : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyLarge,
        prefixIconConstraints: BoxConstraints(maxHeight: 24, minWidth: 24),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 8, left: 16),
          child: widget.prefixIcon,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isObSecure = !isObSecure;
            });
          },
          icon: Icon(
            isObSecure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.white,
          ),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: widget.suffixIcon,
        ),
      ),
    );
  }
}

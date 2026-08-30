import 'package:flutter/material.dart';

import '../core/AppThemeManager/AppColors.dart';
import '../core/gen/assets.gen.dart';

class LanguageSelectorWidget extends StatefulWidget {
  const LanguageSelectorWidget({super.key});

  @override
  State<LanguageSelectorWidget> createState() =>
      _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColors.yellow,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Arabic
          GestureDetector(
            onTap: () {
              setState(() {
                isArabic = true;
              });
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: isArabic
                      ? AppColors.yellow
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                  image: Assets.images.eg.provider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          // English
          GestureDetector(
            onTap: () {
              setState(() {
                isArabic = false;
              });
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: !isArabic
                      ? AppColors.yellow
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                  image: Assets.images.lr.provider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
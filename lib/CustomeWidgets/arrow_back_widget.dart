import 'package:flutter/material.dart';

import '../core/AppThemeManager/app_colors.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back, color: AppColors.yellow, size: 24),
    );
  }
}

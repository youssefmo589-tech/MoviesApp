import 'package:flutter/material.dart';

import '../core/app_theme_manager/app_colors.dart';

class ArrowBackWidget extends StatelessWidget {
  final Color color;
  const ArrowBackWidget({super.key, this.color = AppColors.yellow});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back, color: color, size: 24),
    );
  }
}

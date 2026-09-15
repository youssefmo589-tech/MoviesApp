import 'package:flutter/material.dart';

import '../core/app_theme_manager/app_colors.dart';

class GenresContainer extends StatelessWidget {
  String title;

  GenresContainer({super.key, required this.title});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      width: 122,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

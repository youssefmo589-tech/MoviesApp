import 'package:flutter/material.dart';

import '../core/app_theme_manager/app_colors.dart';

class MovieDetailsWidget extends StatelessWidget {
  final Widget icon;
  final String data;

  const MovieDetailsWidget({
    super.key,
    required this.data,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            const SizedBox(width: 5),
            Text(
              data,
              style: theme.titleLarge?.copyWith(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
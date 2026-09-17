import 'package:flutter/material.dart';

import '../core/app_theme_manager/app_colors.dart';

class AvatarBottomSheet extends StatelessWidget {
  final Image image;

  final bool isSelected;

  final int index;

  const AvatarBottomSheet({
    super.key,
    this.index = -1,
    required this.image,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected == false
              ? Colors.transparent
              : AppColors.yellow.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.yellow, width: 1.5),
        ),
        child: Center(
          child: Padding(padding: const EdgeInsets.all(8.0), child: image),
        ),
      ),
    );
  }
}

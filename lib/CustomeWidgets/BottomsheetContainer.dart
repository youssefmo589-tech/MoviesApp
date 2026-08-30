import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/AppThemeManager/AppColors.dart';

class BottomsheetContainer extends StatelessWidget {
  final Image image;

  bool isselected;

  int index;

  BottomsheetContainer({
    super.key,
    this.index = -1,
    required this.image,
    this.isselected = false,
  });

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: isselected == false
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

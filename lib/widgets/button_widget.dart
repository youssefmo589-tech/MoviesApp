import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color buttoncolor;

  final String title;

  final Color titlecolor;

  final Function? onTap;
  final Widget? icon;

  ButtonWidget({
    super.key,
    required this.title,
    required this.buttoncolor,
    required this.titlecolor,
    this.onTap, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ?icon,
              if (icon != null) SizedBox(width: 12),
              Text(
                title,
                style: theme.titleSmall?.copyWith(color: titlecolor, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

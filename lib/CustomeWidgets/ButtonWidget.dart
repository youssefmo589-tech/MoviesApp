import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color buttoncolor;

  final String title;

  final Color titlecolor;

  final Function? onTap;

  ButtonWidget({
    super.key,
    required this.title,
    required this.buttoncolor,
    required this.titlecolor,
    this.onTap,
  }); //////required this.onTap

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: 55.72218704223633,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            style: theme.titleSmall?.copyWith(color: titlecolor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FavoritesIconWidget extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoritesIconWidget({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        isFavorite
            ? Icons.bookmark_outlined
            : Icons.bookmark_outline,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
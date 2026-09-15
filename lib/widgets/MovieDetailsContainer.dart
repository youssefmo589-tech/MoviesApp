import 'package:flutter/material.dart';

import '../core/app_theme_manager/app_colors.dart';

class MovieDetailsContainer extends StatelessWidget {
  final String name;

  final String charachter;

  final String image;

  MovieDetailsContainer({
    super.key,
    required this.name,
    required this.charachter,
    required this.image,
  });

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.all(11),
        child: Row(
          spacing: 10,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              spacing: 11,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name : $name",
                  style: theme.titleSmall?.copyWith(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Charachter : $charachter",
                  style: theme.titleSmall?.copyWith(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

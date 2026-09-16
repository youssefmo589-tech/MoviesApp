import 'package:flutter/material.dart';

import '../core/app_theme_manager/app_colors.dart';
import '../modules/movie_details_feature/domain/entities/cast_entity.dart';

class MovieDetailsContainer extends StatelessWidget {
  final CastEntity cast;

  const MovieDetailsContainer({super.key, required this.cast});

  @override
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
                  image: NetworkImage(cast.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 11,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : ${cast.name}",
                    style: theme.titleSmall?.copyWith(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Character : ${cast.characterName}",
                    maxLines: 2,
                    style: theme.titleSmall?.copyWith(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

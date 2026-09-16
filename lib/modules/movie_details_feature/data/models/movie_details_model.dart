import 'package:movieapp/modules/movie_details_feature/domain/entities/movie_details_entity.dart';

import '../../domain/entities/cast_entity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  MovieDetailsModel({
    required super.id,
    required super.imageLarge,
    required super.name,
    required super.year,
    required super.likes,
    required super.time,
    required super.rating,
    required super.screenShots,
    required super.summary,
    required super.cast,
    required super.genres,
  });
  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {

    final movie = json['data']['movie'] as Map<String, dynamic>;

    final screenshots = <String>[
      if (movie['large_screenshot_image1'] != null) movie['large_screenshot_image1'] as String,
      if (movie['large_screenshot_image2'] != null) movie['large_screenshot_image2'] as String,
      if (movie['large_screenshot_image3'] != null) movie['large_screenshot_image3'] as String,
    ];

    final castList = (movie['cast'] as List<dynamic>? ?? [])
        .map((castMember) {
          final c = castMember as Map<String, dynamic>;
          return CastEntity(
            name: c['name'] ,
            characterName: c['character_name'] as String? ?? '',
            image: c['url_small_image'] ,
          );
    })
        .toList();
/////////////////////////////////// ++Important++ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    return MovieDetailsModel(
      id: movie['id'] as int,
      imageLarge: movie['large_cover_image'] as String? ?? '',
      name: movie['title'] as String? ?? '',
      year: movie['year'] as int? ?? 0,
      likes: movie['like_count'] as int? ?? 0,
      time: movie['runtime'] as int? ?? 0,
      rating: (movie['rating'] as num?)?.toDouble() ?? 0.0,
      screenShots: screenshots,
      summary: movie['summary'] as String? ?? movie['description_full'] as String? ?? '',
      cast: castList,
      genres: List<String>.from(movie['genres'] as List<dynamic>? ?? []),
    );
  }
}
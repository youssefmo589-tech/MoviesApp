import 'package:movieapp/modules/movie_details_feature/domain/entities/cast_entity.dart';

class MovieDetailsEntity {
  final int id;
  final String imageLarge;
  final String name;
  final int year;
  final int likes;
  final int time;
  final double rating;
  final List<String> screenShots;
  final String summary;
  final List<CastEntity> cast;
  final List<String> genres;

  MovieDetailsEntity({
    required this.id,
    required this.imageLarge,
    required this.name,
    required this.year,
    required this.likes,
    required this.time,
    required this.rating,
    required this.screenShots,
    required this.summary,
    required this.cast,
    required this.genres,
  });
}
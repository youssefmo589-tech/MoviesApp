import '../../domain/entities/movie_details_entity.dart';

abstract class MovieDetailsEvent {}

class MovieSelectedEvent extends MovieDetailsEvent {
  final int id;

  MovieSelectedEvent({required this.id});
}

class MovieSimilarEvent extends MovieDetailsEvent {
  final int id;

  MovieSimilarEvent({required this.id});
}


import '../../domain/entities/movie_details_entity.dart';

abstract class MovieDetailsState {}

class MovieInitial extends MovieDetailsState {}

class MovieLoading extends MovieDetailsState {}

class MovieSuccess extends MovieDetailsState {
 final MovieDetailsEntity movieDetails;
  final bool isFavorite;

  List<MovieDetailsEntity> similarmovies;

  MovieSuccess({required this.movieDetails, required this.similarmovies, required this.isFavorite});
}

class MovieError extends MovieDetailsState {
  final String message;

  MovieError(this.message);
}
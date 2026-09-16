
import '../../domain/entities/movie_details_entity.dart';

abstract class MovieDetailsState {}

class MovieInitial extends MovieDetailsState {}

class MovieLoading extends MovieDetailsState {}

class MovieSuccess extends MovieDetailsState {
 final MovieDetailsEntity movieDetails;
  MovieSuccess({required this.movieDetails});

}

class MovieError extends MovieDetailsState {
  final String message;

  MovieError(this.message);
}
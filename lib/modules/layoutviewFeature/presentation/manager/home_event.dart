part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchMoviesEvent extends HomeEvent {}

class FetchRandomGenreSuggestionsEvent extends HomeEvent {}

class FetchMoviesByGenresEvent extends HomeEvent {
  final List<String> genres;
  FetchMoviesByGenresEvent(this.genres);
}

class SelectGenreEvent extends HomeEvent {
  final String genre;
  SelectGenreEvent(this.genre);
}
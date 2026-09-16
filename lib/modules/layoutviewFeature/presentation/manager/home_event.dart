part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchMoviesEvent extends HomeEvent {}

class FetchRandomGenreSuggestionsEvent extends HomeEvent {}

class SelectGenreEvent extends HomeEvent {
  final String genre;
  SelectGenreEvent(this.genre);
}
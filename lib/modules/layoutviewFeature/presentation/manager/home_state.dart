part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List movies;
  HomeLoaded(this.movies);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeSuggestionsLoadingState extends HomeState {}

class HomeSuggestionsSuccessState extends HomeState {
  final List movies;
  final String genre;

  HomeSuggestionsSuccessState({
    required this.movies,
    required this.genre,
  });
}

class HomeSuggestionsErrorState extends HomeState {
  final String message;
  HomeSuggestionsErrorState(this.message);
}
part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List movies;

  final String currentCategory;

  HomeLoaded(this.movies, {this.currentCategory = 'Action'});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final List<MovieModel> watchList;
  final List<MovieModel> history;

  ProfileLoadedState({
    required this.watchList,
    required this.history,
  });
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message);
}

class LoadingState extends ProfileState {}

class SuccessState extends ProfileState {}

class ErrorState extends ProfileState {
  final String? message;
  ErrorState(this.message);
}
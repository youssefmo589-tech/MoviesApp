import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:movieapp/modules/movie_details_feature/domain/entities/movie_details_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final List<MovieModel> watchList;
  final List<MovieModel> history;
  final List<MovieDetailsEntity> favorites;

  ProfileLoadedState({
    required this.watchList,
    required this.history,
    this.favorites = const [],
  });

  ProfileLoadedState copyWith({
    List<MovieModel>? watchList,
    List<MovieModel>? history,
    List<MovieDetailsEntity>? favorites,
  }) {
    return ProfileLoadedState(
      watchList: watchList ?? this.watchList,
      history: history ?? this.history,
      favorites: favorites ?? this.favorites,
    );
  }
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
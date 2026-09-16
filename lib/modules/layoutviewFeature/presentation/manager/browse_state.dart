import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseSuccess extends BrowseState {
  final List<MovieModel> movies;
  final int selectedCategoryIndex;

  BrowseSuccess({required this.movies, required this.selectedCategoryIndex});
}

class BrowseError extends BrowseState {
  final String message;

  BrowseError(this.message);
}
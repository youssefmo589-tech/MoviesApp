import '../../datalayer/Models/movie_model.dart';

abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistorySuccessState extends HistoryState {
  final List<MovieModel> movies;
  HistorySuccessState(this.movies);
}

class HistoryErrorState extends HistoryState {
  final String errorMessage;
  HistoryErrorState(this.errorMessage);
}
import '../../datalayer/Models/movie_model.dart';

abstract class HistoryEvent {}

class AddMovieToHistoryEvent extends HistoryEvent {
  final MovieModel movie;
  AddMovieToHistoryEvent(this.movie);
}

class GetHistoryMoviesEvent extends HistoryEvent {}
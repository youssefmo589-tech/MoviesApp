import '../../datalayer/Models/movie_model.dart';

abstract class HistoryRepository {


  Future<void> addMovieToHistory(MovieModel movie);


  Future<List<MovieModel>> getHistoryMovies();
}

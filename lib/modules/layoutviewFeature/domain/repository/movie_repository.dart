import '../../datalayer/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMovies();
  Future<List<MovieModel>> getMoviesByGenre(String genre);
}
import '../../datalayer/Models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMovies();
}
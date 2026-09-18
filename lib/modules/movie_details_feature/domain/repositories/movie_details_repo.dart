import '../entities/movie_details_entity.dart';

abstract class MovieDetailsRepo {

  Future<MovieDetailsEntity> getMovieDetails(int id);

  Future<List<MovieDetailsEntity>> getSimilarMovies(int id);
}
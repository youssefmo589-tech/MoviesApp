import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMovies();
}
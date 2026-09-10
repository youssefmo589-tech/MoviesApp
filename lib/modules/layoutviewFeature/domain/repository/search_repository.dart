import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';

abstract class SearchRepository {
  Future<List<MovieModel>> searchMovies(String query);
}
import 'package:dio/dio.dart';
import '../models/movie_model.dart'; // ✅ تعديل المسار بحرف m صغير

class MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSource({Dio? dio}) : dio = dio ?? Dio();

  Future<List<MovieModel>> getMovies() async {
    try {
      final response = await dio.get('https://yts.gg/api/v2/list_movies.json');
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        final List moviesList = response.data['data']['movies'] ?? [];
        return moviesList.map((movie) => MovieModel.fromJson(movie)).toList();
      }
      throw Exception('Failed to load movies');
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<List<MovieModel>> getMoviesByGenre(String genre) async {
    try {
      final response = await dio.get(
        'https://yts.gg/api/v2/list_movies.json',
        queryParameters: {
          'genre': genre,
          'limit': 15,
        },
      );
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        final List moviesJson = response.data['data']['movies'] ?? [];
        return moviesJson.map((e) => MovieModel.fromJson(e)).toList();
      }
      throw Exception('Failed to load movies by genre');
    } catch (e) {
      rethrow;
    }
  }
}
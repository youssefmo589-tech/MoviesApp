import 'package:dio/dio.dart';

import '../models/movie_details_model.dart';

class MovieDetailsDataSource {
  final dio = Dio();

  Future<MovieDetailsModel> getMovieDetails(int id) async {
    try {
      final response = await dio.get(
        "https://movies-api.accel.li/api/v2/movie_details.json",
        queryParameters: {
          "movie_id": id,
          "with_images": true,
          "with_cast": true,
        },
      );
      final movie = response.data['data']['movie'] as Map<String, dynamic>;
      return MovieDetailsModel.fromJson(movie);
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

  Future<List<MovieDetailsModel>> getSimilarMovies(int id) async {
    try {
      final response = await dio.get(
        "https://yts.gg/api/v2/movie_suggestions.json",
        queryParameters: {"movie_id": id},
      );

      final data = response.data['data']['movies'] as List<dynamic>? ?? [];

      final movies = <MovieDetailsModel>[];
      for (var movie in data) {
        movies.add(MovieDetailsModel.fromJson(movie as Map<String, dynamic>));
      }

      return movies;
    } catch (error) {
      throw Exception("Failed to load suggestions movies: $error");
    }
  }
}
import '../Models/movie_model.dart';
import 'package:dio/dio.dart';


class MovieRemoteDataSource {
  final Dio dio = Dio();

  Future<List<MovieModel>> getMovies() async {
    try {
      final response = await dio.get('https://yts.gg/api/v2/list_movies.json');
      final List moviesList = response.data['data']['movies'];
      return moviesList.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }
}
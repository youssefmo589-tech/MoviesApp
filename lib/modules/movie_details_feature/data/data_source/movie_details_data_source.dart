import 'package:dio/dio.dart';

import '../models/movie_details_model.dart';

class MovieDetailsDataSource {

  final dio = Dio();

  Future<MovieDetailsModel> getMovieDetails(int id) async {
    try {
      final response = await dio.get("https://movies-api.accel.li/api/v2/movie_details.json",
      queryParameters: {
        "movie_id": id,
        "with_images": true,
        "with_cast": true,
      }
      );
      return MovieDetailsModel.fromJson(response.data);

    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}

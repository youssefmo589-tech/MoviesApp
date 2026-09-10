import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';

class BrowseRemoteDataSource {
  Future<List<MovieModel>> getMoviesByGenre(String genre) async {
    final Uri url = Uri.parse('https://yts.lt/api/v2/list_movies.json?genre=$genre');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'ok' && data['data']['movies'] != null) {
          final List moviesJson = data['data']['movies'];
          return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movies. Please check connection.');
    }
  }
}
import 'dart:math';

class GenreHelper {
  static const List<String> genres = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Drama',
  ];

  static String getRandomGenre() {
    final random = Random();
    return genres[random.nextInt(genres.length)];
  }
}
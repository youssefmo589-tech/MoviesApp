import 'dart:math';

class GenreHelper {
  static const List<String> genres = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Drama',
  ];
static List<String> getRandomGenres({int count = 3}) {
  final random = Random();
  final List<String> shuffled = List.from(genres)
    ..shuffle(random);
  return shuffled.take(count).toList();
}
}
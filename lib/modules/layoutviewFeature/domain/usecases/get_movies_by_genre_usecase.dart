import '../../domain/repository/movie_repository.dart';
import '../../datalayer/models/movie_model.dart';

class GetMoviesByGenreUseCase {
  final MovieRepository repository;

  GetMoviesByGenreUseCase(this.repository);

  Future<List<MovieModel>> call(String genre) {
    return repository.getMoviesByGenre(genre);
  }
}
import '../repository/movie_repository.dart';
import '../../datalayer/Models/movie_model.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<MovieModel>> call() async {
    return await repository.getMovies();
  }
}
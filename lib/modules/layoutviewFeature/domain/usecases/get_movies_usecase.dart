import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/repository/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<MovieModel>> call() async {
    return await repository.getMovies();
  }
}
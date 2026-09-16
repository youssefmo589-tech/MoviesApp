import '../../datalayer/repositoryImp/browse_repository_impl.dart';
import '../../datalayer/models/movie_model.dart';

class GetMoviesByGenreUseCase {
  final BrowseRepositoryImpl repository;

  GetMoviesByGenreUseCase(this.repository);

  Future<List<MovieModel>> call(String genre) {
    return repository.getMoviesByGenre(genre);
  }
}
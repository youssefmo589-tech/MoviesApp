import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/repositoryImp/browse_repository_impl.dart';

class GetMoviesByGenreUseCase {
  final BrowseRepositoryImpl repository;

  GetMoviesByGenreUseCase(this.repository);

  Future<List<MovieModel>> call(String genre) {
    return repository.getMoviesByGenre(genre);
  }
}
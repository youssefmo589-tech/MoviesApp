import '../entities/movie_details_entity.dart';
import '../repositories/movie_details_repo.dart';

class GetSimilarMoviesUsecase {
  MovieDetailsRepo _moviedetailsrepo;

  GetSimilarMoviesUsecase({required this._moviedetailsrepo});

  Future<List<MovieDetailsEntity>> call(int id) async {
    return _moviedetailsrepo.getSimilarMovies(id);
  }
}

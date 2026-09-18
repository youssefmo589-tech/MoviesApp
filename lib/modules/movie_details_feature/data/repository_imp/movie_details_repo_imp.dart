import '../../domain/entities/movie_details_entity.dart';
import '../../domain/repositories/movie_details_repo.dart';
import '../data_source/movie_details_data_source.dart';

class MovieDetailsRepoImp implements MovieDetailsRepo {
  final MovieDetailsDataSource dataSource;
  MovieDetailsRepoImp(this.dataSource);

  @override
  Future<MovieDetailsEntity> getMovieDetails(int id) async {
    final movieDetailsModel = await dataSource.getMovieDetails(id);
    return movieDetailsModel;
  }

  @override
  Future<List<MovieDetailsEntity>> getSimilarMovies(int id) async {
    return await dataSource.getSimilarMovies(id);
  }
}

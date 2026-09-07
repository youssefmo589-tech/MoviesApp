import '../../domain/repository/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';
import '../Models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieModel>> getMovies() async {
    return await remoteDataSource.getMovies();
  }
}
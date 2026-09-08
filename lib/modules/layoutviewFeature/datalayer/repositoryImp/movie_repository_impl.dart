import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/movie_remote_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieModel>> getMovies() async {
    return await remoteDataSource.getMovies();
  }
}
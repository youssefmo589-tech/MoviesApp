import '../../domain/repository/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieModel>> getMovies() async {
    return await remoteDataSource.getMovies();
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(String genre) async {
    return await remoteDataSource.getMoviesByGenre(genre);
  }
}
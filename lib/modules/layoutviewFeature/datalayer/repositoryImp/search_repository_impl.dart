import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/search_remote_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    return await remoteDataSource.searchMovies(query);
  }
}
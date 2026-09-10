import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/browse_remote_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';

class BrowseRepositoryImpl {
  final BrowseRemoteDataSource remoteDataSource;

  BrowseRepositoryImpl(this.remoteDataSource);

  Future<List<MovieModel>> getMoviesByGenre(String genre) {
    return remoteDataSource.getMoviesByGenre(genre);
  }
}
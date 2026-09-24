import '../../domain/repository/history_repository.dart';
import '../Models/movie_model.dart';
import '../datasources/history_remote_data_source.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addMovieToHistory(MovieModel movie) async {
    return await remoteDataSource.addMovieToHistory(movie);
  }

  @override
  Future<List<MovieModel>> getHistoryMovies() async {
    return await remoteDataSource.getHistoryMovies();
  }
}
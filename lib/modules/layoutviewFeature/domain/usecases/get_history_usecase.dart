import '../../datalayer/Models/movie_model.dart';
import '../repository/history_repository.dart';

class GetHistoryUseCase {
  final HistoryRepository repository;

  GetHistoryUseCase(this.repository);

  Future<List<MovieModel>> call() async {
    return await repository.getHistoryMovies();
  }
}
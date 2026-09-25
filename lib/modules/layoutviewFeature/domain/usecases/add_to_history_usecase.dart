import '../../datalayer/Models/movie_model.dart';
import '../repository/history_repository.dart';

class AddToHistoryUseCase {
  final HistoryRepository repository;

  AddToHistoryUseCase(this.repository);

  Future<void> call(MovieModel movie) async {
    return await repository.addMovieToHistory(movie);
  }
}
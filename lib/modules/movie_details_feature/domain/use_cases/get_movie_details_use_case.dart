import '../entities/movie_details_entity.dart';
import '../repositories/movie_details_repo.dart';

class GetMovieDetailsUseCase {

  final MovieDetailsRepo movieDetailsRepo;
  GetMovieDetailsUseCase(this.movieDetailsRepo);

  Future<MovieDetailsEntity> getMovieDetails(int id) async {
    return await movieDetailsRepo.getMovieDetails(id);

  }
}
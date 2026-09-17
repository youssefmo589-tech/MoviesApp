import 'package:bloc/bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/repositoryImp/RepositoryImp.dart';
import 'package:movieapp/modules/movie_details_feature/domain/use_cases/get_similar_movies.dart';

import '../../data/data_source/movie_details_data_source.dart';
import '../../data/repository_imp/movie_details_repo_imp.dart';
import '../../domain/repositories/movie_details_repo.dart';
import '../../domain/use_cases/get_movie_details_use_case.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMoviesDetailsUseCase;

  late MovieDetailsRepoImp _movieDetailsRepoImp;

  late MovieDetailsDataSource _movieDetailsDataSource;

  late GetSimilarMoviesUsecase _getSimilarMoviesUsecase;

  MovieDetailsBloc({required this.getMoviesDetailsUseCase}) : super(MovieInitial()) {
    on<MovieSelectedEvent>(_onMovieDetails);
  }

  Future<void> _onMovieDetails(MovieSelectedEvent event,
      Emitter<MovieDetailsState> emit) async {
    emit(MovieLoading());


    _movieDetailsDataSource = MovieDetailsDataSource();

    _movieDetailsRepoImp = MovieDetailsRepoImp(_movieDetailsDataSource);

    _getSimilarMoviesUsecase =
        GetSimilarMoviesUsecase(moviedetailsrepo: _movieDetailsRepoImp);


    try {
      final movieDetails = await getMoviesDetailsUseCase.getMovieDetails(
          event.id);
      final similarmovies = await _getSimilarMoviesUsecase.call(event.id);
      emit(MovieSuccess(
          movieDetails: movieDetails, similarmovies: similarmovies));
    } catch (e) {
      emit(MovieError(
          'Failed to fetch movie details. Please check your internet connection.'));
    }
  }

}
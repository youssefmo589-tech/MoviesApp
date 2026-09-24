import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movieapp/modules/movie_details_feature/domain/use_cases/get_similar_movies.dart';
import '../../../../core/FirebaseCloudService/FirestoreCloudService.dart';
import '../../data/data_source/movie_details_data_source.dart';
import '../../data/repository_imp/movie_details_repo_imp.dart';
import '../../domain/use_cases/get_movie_details_use_case.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMoviesDetailsUseCase;

  late MovieDetailsRepoImp _movieDetailsRepoImp;
  late MovieDetailsDataSource _movieDetailsDataSource;
  late GetSimilarMoviesUsecase _getSimilarMoviesUsecase;

  MovieDetailsBloc({required this.getMoviesDetailsUseCase})
    : super(MovieInitial()) {
    on<MovieSelectedEvent>(_onMovieDetails);
    on<MovieFavoriteEvent>(_onMovieFavorite);
  }

  Future<void> _onMovieDetails(
    MovieSelectedEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieLoading());

    _movieDetailsDataSource = MovieDetailsDataSource();
    _movieDetailsRepoImp = MovieDetailsRepoImp(_movieDetailsDataSource);
    _getSimilarMoviesUsecase = GetSimilarMoviesUsecase(
      moviedetailsrepo: _movieDetailsRepoImp,
    );

    try {
      final movieDetails = await getMoviesDetailsUseCase.getMovieDetails(
        event.id,
      );
      final favoriteMovies = await FirestoreCloudService.getFavoriteMovies();
      final isFavorite = favoriteMovies.contains(movieDetails.id.toString());
      final similarmovies = await _getSimilarMoviesUsecase.call(event.id);
      emit(
        MovieSuccess(
            movieDetails: movieDetails,
            similarmovies: similarmovies,
          isFavorite: isFavorite,
        ),
      );
    } catch (e) {
      emit(
        MovieError(
          'Failed to fetch movie details. Please check your internet connection.',
        ),
      );
    }
  }

  Future<void> _onMovieFavorite(MovieFavoriteEvent event, Emitter<MovieDetailsState> emit) async{
    if (state is! MovieSuccess) return;

    final currentState = state as MovieSuccess;

    if (currentState.isFavorite) {
      final success =
      await FirestoreCloudService.removeFavoriteMovie(event.id.toString());

      if (success) {
        emit(
          MovieSuccess(
            movieDetails: currentState.movieDetails,
            similarmovies: currentState.similarmovies,
            isFavorite: false,
          ),
        );
      }
    } else {
      final success =
      await FirestoreCloudService.addFavoriteMovie(event.id.toString());

      if (success) {
        emit(
          MovieSuccess(
            movieDetails: currentState.movieDetails,
            similarmovies: currentState.similarmovies,
            isFavorite: true,
          ),
        );
      }
    }

  }
}

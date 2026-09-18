import 'package:bloc/bloc.dart';

import '../../domain/use_cases/get_movie_details_use_case.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMoviesDetailsUseCase;

  MovieDetailsBloc({required this.getMoviesDetailsUseCase}) : super(MovieInitial()) {
    on<MovieSelectedEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final movieDetails = await getMoviesDetailsUseCase.getMovieDetails(event.id);
        emit(MovieSuccess( movieDetails: movieDetails));
        } catch (e) {
        emit(MovieError('Failed to fetch movie details. Please check your internet connection.'));
      }
    });
  }
}
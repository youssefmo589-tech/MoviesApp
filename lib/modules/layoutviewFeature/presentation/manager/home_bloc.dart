import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_movies_by_genre_usecase.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import '../../domain/utils/genre_helper.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase getMoviesUseCase;
  final GetMoviesByGenreUseCase getMoviesByGenreUseCase;

  List<dynamic> movies = [];

  HomeBloc({
    required this.getMoviesUseCase,
    required this.getMoviesByGenreUseCase,
  }) : super(HomeInitial()) {

    on<FetchMoviesEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final fetchedMovies = await getMoviesUseCase();
        movies = fetchedMovies;
        emit(HomeLoaded(movies));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<SelectGenreEvent>((event, emit) async {
      emit(HomeSuggestionsLoadingState());
      try {
        final suggestionMovies = await getMoviesByGenreUseCase(event.genre);
        emit(HomeSuggestionsSuccessState(
          movies: suggestionMovies,
          genre: event.genre,
        ));
      } catch (e) {
        emit(HomeSuggestionsErrorState(e.toString()));
      }
    });

    on<FetchRandomGenreSuggestionsEvent>((event, emit) async {
      emit(HomeSuggestionsLoadingState());
      try {
        final randomGenre = GenreHelper.getRandomGenre();
        final suggestionMovies = await getMoviesByGenreUseCase(randomGenre);
        emit(HomeSuggestionsSuccessState(
          movies: suggestionMovies,
          genre: randomGenre,
        ));
      } catch (e) {
        emit(HomeSuggestionsErrorState(e.toString()));
      }
    });
  }
}
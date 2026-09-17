import 'package:bloc/bloc.dart';
import '../../datalayer/models/movie_model.dart';
import '../../domain/usecases/get_movies_by_genre_usecase.dart';
import '../../domain/usecases/get_movies_usecase.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase getMoviesUseCase;
  final GetMoviesByGenreUseCase getMoviesByGenreUseCase;

  List<MovieModel> movies = [];
  Map<String, List<MovieModel>> genreMoviesMap = {};

  HomeBloc({
    required this.getMoviesUseCase,
    required this.getMoviesByGenreUseCase,
  }) : super(HomeInitial()) {


    on<FetchMoviesEvent>(_onFetchMovies);


    on<FetchMoviesByGenresEvent>(_onFetchMoviesByGenres);


    on<FetchRandomGenreSuggestionsEvent>(_onFetchRandomGenreSuggestions);
  }

  Future<void> _onFetchMovies(FetchMoviesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final fetchedMovies = await getMoviesUseCase();
      movies = fetchedMovies;
      emit(HomeLoaded(movies: movies, genreMoviesMap: genreMoviesMap));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onFetchMoviesByGenres(FetchMoviesByGenresEvent event, Emitter<HomeState> emit) async {
    final missingGenres = event.genres.where((genre) => !genreMoviesMap.containsKey(genre)).toList();

    if (missingGenres.isNotEmpty) {
      try {
        final results = await Future.wait(
          missingGenres.map((genre) => getMoviesByGenreUseCase(genre)),
        );

        for (int i = 0; i < missingGenres.length; i++) {
          genreMoviesMap[missingGenres[i]] = results[i];
        }
      } catch (_) {
        for (var genre in missingGenres) {
          genreMoviesMap.putIfAbsent(genre, () => []);
        }
      }
    }

    emit(HomeLoaded(
      movies: movies,
      genreMoviesMap: Map<String, List<MovieModel>>.from(genreMoviesMap),
    ));
  }

  Future<void> _onFetchRandomGenreSuggestions(
      FetchRandomGenreSuggestionsEvent event,
      Emitter<HomeState> emit,
      ) async {
    try {
      const List<String> availableGenres = ['Action', 'Comedy', 'Drama', 'Sci-Fi', 'Horror'];
      final String randomGenre = (availableGenres..shuffle()).first;

      if (!genreMoviesMap.containsKey(randomGenre)) {
        final suggestedMovies = await getMoviesByGenreUseCase(randomGenre);
        genreMoviesMap[randomGenre] = suggestedMovies;
      }

      emit(HomeLoaded(
        movies: movies,
        genreMoviesMap: Map<String, List<MovieModel>>.from(genreMoviesMap),
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
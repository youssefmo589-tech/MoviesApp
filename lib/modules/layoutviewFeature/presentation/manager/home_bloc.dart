import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_movies_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase getMoviesUseCase;


  final List<String> categories = ['Action', 'Comedy', 'Drama', 'Sci-Fi', 'Romance', 'Animation', 'Adventure'];

  HomeBloc(this.getMoviesUseCase) : super(HomeInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<RefreshHomeCategoriesEvent>(_onRefreshHomeCategories);
  }

  Future<void> _onFetchMovies(FetchMoviesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      categories.shuffle();
      final movies = await getMoviesUseCase();
      emit(HomeLoaded(movies, currentCategory: categories.first));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshHomeCategories(RefreshHomeCategoriesEvent event, Emitter<HomeState> emit) async {

    add(FetchMoviesEvent());
  }
}
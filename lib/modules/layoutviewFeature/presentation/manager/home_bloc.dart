import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_movies_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase getMoviesUseCase;

  HomeBloc(this.getMoviesUseCase) : super(HomeInitial()) {
    on<FetchMoviesEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final movies = await getMoviesUseCase();
        emit(HomeLoaded(movies));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
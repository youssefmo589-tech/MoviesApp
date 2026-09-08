import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/usecases/get_movies_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMoviesUseCase getMoviesUseCase;

  HomeBloc(this.getMoviesUseCase) : super(HomeInitial()) {
    on<FetchMoviesEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final movie = await getMoviesUseCase();
        emit(HomeSuccess(movie));
      } catch (e) {
        emit(HomeError('Failed to fetch movies. Please check connection.'));
      }
    });
  }
}
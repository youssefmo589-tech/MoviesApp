import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/usecases/get_movies_by_genre_usecase.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/browse_event.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final GetMoviesByGenreUseCase getMoviesByGenreUseCase;

  BrowseBloc(this.getMoviesByGenreUseCase) : super(BrowseInitial()) {
    on<CategorySelectedEvent>((event, emit) async {
      emit(BrowseLoading());
      try {
        final movies = await getMoviesByGenreUseCase(event.genre);
        emit(BrowseSuccess(movies: movies, selectedCategoryIndex: event.index));
      } catch (e) {
        emit(BrowseError('Failed to fetch movies. Please check your internet connection.'));
      }
    });
  }
}
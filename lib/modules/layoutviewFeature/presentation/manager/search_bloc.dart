import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/domain/usecases/search_movies_usecase.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/search_event.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  SearchBloc(this.searchMoviesUseCase) : super(SearchInitial()) {
    on<SearchQueryChangedEvent>((event, emit) async {

      if (event.query.trim().isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      try {
        final movies = await searchMoviesUseCase(event.query);
        emit(SearchSuccess(movies));
      } catch (e) {
        emit(SearchError('Failed to fetch movies. Please check your internet connection.'));
      }
    });
  }
}
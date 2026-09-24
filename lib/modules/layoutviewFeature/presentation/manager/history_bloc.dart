import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_history_usecase.dart';
import '../../domain/usecases/get_history_usecase.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final AddToHistoryUseCase addToHistoryUseCase;
  final GetHistoryUseCase getHistoryUseCase;

  HistoryBloc({
    required this.addToHistoryUseCase,
    required this.getHistoryUseCase,
  }) : super(HistoryInitialState()) {

    on<AddMovieToHistoryEvent>(_onAddMovieToHistory);

    on<GetHistoryMoviesEvent>(_onGetHistoryMovies);
  }

  Future<void> _onAddMovieToHistory(
      AddMovieToHistoryEvent event,
      Emitter<HistoryState> emit,
      ) async {
    try {
      await addToHistoryUseCase(event.movie);
      final movies = await getHistoryUseCase();
      emit(HistorySuccessState(movies));
    } catch (e) {
      print('== History Error: $e ==');
      emit(HistoryErrorState(e.toString()));
    }
  }

  Future<void> _onGetHistoryMovies(
      GetHistoryMoviesEvent event,
      Emitter<HistoryState> emit,
      ) async {
    emit(HistoryLoadingState());
    try {
      final movies = await getHistoryUseCase();
      emit(HistorySuccessState(movies));
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/profile_event.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/profile_state.dart';
import 'package:movieapp/modules/movie_details_feature/domain/use_cases/get_movie_details_use_case.dart';

import '../../datalayer/datasources/profile_local_data_source.dart';
import 'editProfileBloc.dart' hide EditnameEvent, LoadingState, SuccessState, ErrorState, EditphoneEvent, EditimageEvent;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileLocalDataSource localDataSource;
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  ProfileBloc({
    required this.localDataSource,
    required this.getMovieDetailsUseCase,
  }) : super(ProfileInitialState()) {
    on<LoadProfileDataEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final watchList = await localDataSource.getWatchList();
        final history = await localDataSource.getHistory();
        emit(ProfileLoadedState(watchList: watchList, history: history));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });

    on<LoadFavoritesEvent>((event, emit) async {
      try {
        final favorites = await Future.wait(
          event.favoritesId.map(
                (id) => getMovieDetailsUseCase.getMovieDetails(int.parse(id)),
          ),
        );

        final current = state;
        if (current is ProfileLoadedState) {
          emit(current.copyWith(favorites: favorites));
        } else {
          emit(ProfileLoadedState(watchList: [], history: [], favorites: favorites));
        }
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });

    on<AddToWatchListEvent>((event, emit) async {
      try {
        final currentWatchList = await localDataSource.getWatchList();
        currentWatchList.add(event.movie);
        await localDataSource.saveToWatchList(currentWatchList);
        add(LoadProfileDataEvent());
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });

    on<AddToHistoryEvent>((event, emit) async {
      try {
        final currentHistory = await localDataSource.getHistory();
        currentHistory.add(event.movie);
        await localDataSource.saveToHistory(currentHistory);
        add(LoadProfileDataEvent());
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });

    on<EditnameEvent>((event, emit) async {
      emit(LoadingState());
      try {
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(e.toString(), ));
      }
    });

    on<EditphoneEvent>((event, emit) async {
      emit(LoadingState());
      try {
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(e.toString(), ));
      }
    });

    on<EditimageEvent>((event, emit) async {
      emit(LoadingState());
      try {
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
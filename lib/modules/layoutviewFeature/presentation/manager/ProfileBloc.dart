import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/datasources/profile_local_data_source.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/ProfileEvent.dart';
import 'package:movieapp/modules/layoutviewFeature/presentation/manager/ProfileState.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileLocalDataSource localDataSource;

  ProfileBloc({required this.localDataSource}) : super(ProfileInitialState()) {
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
        emit(ErrorState(e.toString()));
      }
    });

    on<EditphoneEvent>((event, emit) async {
      emit(LoadingState());
      try {
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(e.toString()));
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
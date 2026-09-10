import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/modules/layoutviewFeature/datalayer/repositoryImp/RepositoryImp.dart';

import '../../domain/repository/LayoutviewRepositories.dart';
import '../../domain/usecases/EditImageProfileUseCase.dart';
import '../../domain/usecases/EditNameProfileUseCase.dart';
import '../../domain/usecases/EditPhoneProfileUseCase.dart';

part 'editProfileEvent.dart';
part 'editProfileState.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  late EditImageProfileUseCase _editImageProfileUseCase;

  late EditNameProfileUseCase _editNameProfileUseCase;

  late EditPhoneProfileUseCase _editPhoneProfileUseCase;

  late LayoutRepositories _layoutRepositories;

  EditProfileBloc() : super(LoadingState()) {
    on<EditnameEvent>(_oneditname);
    on<EditphoneEvent>(_oneditphone);
    on<EditimageEvent>(_oneditimage);
  }

  Future<void> _oneditname(EditnameEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(LoadingState());

    _layoutRepositories = RepositoryImp();
    _editNameProfileUseCase = EditNameProfileUseCase(_layoutRepositories);

    final bool result = await _editNameProfileUseCase.call(event.name);

    if (result) {
      emit(SuccessState());
    } else {
      emit(ErrorState(message: 'error'));
    }
  }

  Future<void> _oneditphone(
    EditphoneEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(LoadingState());
    _layoutRepositories = RepositoryImp();
    _editPhoneProfileUseCase = EditPhoneProfileUseCase(_layoutRepositories);

    final bool result = await _editPhoneProfileUseCase.call(event.phone);

    if (result) {
      emit(SuccessState());
    } else {
      emit(ErrorState(message: 'error'));
    }
  }

  Future<void> _oneditimage(EditimageEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(LoadingState());

    _layoutRepositories = RepositoryImp();
    _editImageProfileUseCase = EditImageProfileUseCase(_layoutRepositories);
    final bool result = await _editImageProfileUseCase.call(event.image);

    if (result) {
      emit(SuccessState());
    } else {
      emit(ErrorState(message: 'error'));
    }
  }
}

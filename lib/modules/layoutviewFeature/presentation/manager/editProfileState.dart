
part of 'editProfileBloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class InitialState extends EditProfileState {
  const InitialState();
}

class LoadingState extends EditProfileState {
  const LoadingState();
}

class ErrorState extends EditProfileState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessState extends EditProfileState {
  const SuccessState();
}

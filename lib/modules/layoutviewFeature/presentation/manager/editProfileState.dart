
part of 'editProfileBloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class InitialState extends ProfileState {
  const InitialState();
}

class LoadingState extends ProfileState {
  const LoadingState();
}

class ErrorState extends ProfileState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessState extends ProfileState {
  const SuccessState();
}

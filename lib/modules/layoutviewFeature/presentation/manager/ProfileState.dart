part of 'ProfileBloc.dart';

class ProfileState extends Equatable {
  const ProfileState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
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
}

class SuccessState extends ProfileState {
  const SuccessState();
}

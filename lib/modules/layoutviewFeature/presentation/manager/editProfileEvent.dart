part of 'editProfileBloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class EditnameEvent extends ProfileEvent {
  final String name;

  EditnameEvent({required this.name});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class EditphoneEvent extends ProfileEvent {
  final String phone;

  EditphoneEvent({required this.phone});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class EditimageEvent extends ProfileEvent {
  final String image;

  EditimageEvent({required this.image});

  @override
  List<Object?> get props => throw UnimplementedError();
}

part of 'editProfileBloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class EditnameEvent extends EditProfileEvent {
  final String name;

  EditnameEvent({required this.name});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class EditphoneEvent extends EditProfileEvent {
  final String phone;

  EditphoneEvent({required this.phone});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class EditimageEvent extends EditProfileEvent {
  final String image;

  EditimageEvent({required this.image});

  @override
  List<Object?> get props => throw UnimplementedError();
}

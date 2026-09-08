import 'package:movieapp/modules/layoutviewFeature/datalayer/models/movie_model.dart';

abstract class ProfileEvent {}

class LoadProfileDataEvent extends ProfileEvent {}

class AddToWatchListEvent extends ProfileEvent {
  final MovieModel movie;
  AddToWatchListEvent(this.movie);
}

class AddToHistoryEvent extends ProfileEvent {
  final MovieModel movie;
  AddToHistoryEvent(this.movie);
}

class EditnameEvent extends ProfileEvent {
  final String name;
  EditnameEvent({required this.name});
}

class EditphoneEvent extends ProfileEvent {
  final String phone;
  EditphoneEvent({required this.phone});
}

class EditimageEvent extends ProfileEvent {
  final String image;
  EditimageEvent({required this.image});
}
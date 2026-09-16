abstract class MovieDetailsEvent {}

class MovieSelectedEvent extends MovieDetailsEvent {
  final int id;


  MovieSelectedEvent({required this.id});
}
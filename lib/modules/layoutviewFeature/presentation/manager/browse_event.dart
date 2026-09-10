abstract class BrowseEvent {}

class CategorySelectedEvent extends BrowseEvent {
  final String genre;
  final int index;

  CategorySelectedEvent({required this.genre, required this.index});
}
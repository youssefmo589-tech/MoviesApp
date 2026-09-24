class UserEntity {
  String name;
  String phone;
  String image;
  String? userID;
  List<String> favoriteMovies;

  UserEntity({
    required this.name,
    required this.phone,
    required this.image,
    this.userID,
    this.favoriteMovies = const [],
  });
}

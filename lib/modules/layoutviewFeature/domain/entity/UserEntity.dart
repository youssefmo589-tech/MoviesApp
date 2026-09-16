class UserEntity {
  String name;

  String phone;

  String image;

  String? userID;

  UserEntity({
    required this.name,
    required this.phone,
    required this.image,
    this.userID,
  });
}

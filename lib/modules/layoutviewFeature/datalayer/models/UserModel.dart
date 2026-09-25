import 'package:movieapp/modules/layoutviewFeature/domain/entity/UserEntity.dart';

class UserModel extends UserEntity {
  static const String collectionname = "users";

  UserModel({
    required super.name,
    required super.phone,
    required super.image,
    super.userID,
    super.favoriteMovies,
  });

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
      favoriteMovies: List<String>.from(json['favoriteMovies']),
    );
  }

  Map<String, dynamic> tofirestore() {
    return {
      "name": name,
      "phone": phone,
      "image": image,
      "userID": userID,
      "favoriteMovies": favoriteMovies,
    };
  }
}

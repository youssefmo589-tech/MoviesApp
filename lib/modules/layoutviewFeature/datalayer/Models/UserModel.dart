import 'package:movieapp/modules/layoutviewFeature/domain/entity/UserEntity.dart';

class UserModel extends UserEntity {
  static const String collectionname = "users";

  UserModel({
    required super.name,
    required super.phone,
    required super.image,
    super.userID,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
    );
  }


  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel.fromJson(json);


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "image": image,
      "userID": userID,
    };
  }


  Map<String, dynamic> tofirestore() => toJson();
}
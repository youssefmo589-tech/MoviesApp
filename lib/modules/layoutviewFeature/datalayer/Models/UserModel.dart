import 'package:movieapp/modules/layoutviewFeature/domain/entity/UserEntity.dart';

class UserModel extends UserEntity {
  static const String collectionname = "users";

  UserModel({
    required super.name,
    required super.phone,
    required super.image,
    required super.userID,
  });

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
    );
  }

  Map<String, dynamic> tofirestore() {
    return {"name": name, "phone": phone, "image": image, "userID": userID};
  }
}

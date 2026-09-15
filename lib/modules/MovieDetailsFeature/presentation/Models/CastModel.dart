import 'package:movieapp/modules/MovieDetailsFeature/domain/Entities/CastEntity.dart';

class CastModel extends CastEntity {
  CastModel({
    required super.name,
    required super.charachter,
    required super.image,
  });

  factory CastModel.fromjson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'],
      charachter: json['charachter'],
      image: json['image'],
    );
  }
}

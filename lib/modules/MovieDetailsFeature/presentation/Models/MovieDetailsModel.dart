import 'package:movieapp/modules/MovieDetailsFeature/presentation/Models/CastModel.dart';

import '../../domain/Entities/MovieDetailsEntity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  MovieDetailsModel({required super.Summary, required super.cast});

  factory MovieDetailsModel.fromjson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      Summary: json['Summary'],
      cast: CastModel.fromjson(json['cast']),
    );
  }
}

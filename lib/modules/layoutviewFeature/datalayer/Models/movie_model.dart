class MovieModel {
  final int? id;
  final String? title;
  final String? mediumCoverImage;
  final double? rating;

  MovieModel({
    this.id,
    this.title,
    this.mediumCoverImage,
    this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      mediumCoverImage: json['medium_cover_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'medium_cover_image': mediumCoverImage,
      'rating': rating,
    };
  }
}
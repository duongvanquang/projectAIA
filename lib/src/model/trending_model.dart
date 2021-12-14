import '../helper/string_helper.dart';

class TrendingModel {
  final String? overview;
  final String? backdropPath;
  final int? voteCount;
  final String? originalLanguage;
  final int? id;
  final String? posterPath;
  final double? voteAverage;
  final double? popularity;
  final String? mediaType;
  final String? releaseDate;
  final String? title;
  final String? name;
  final String? firstAirDate;

  const TrendingModel({
    this.overview,
    this.backdropPath,
    this.voteCount,
    this.originalLanguage,
    this.id,
    this.posterPath,
    this.voteAverage,
    this.popularity,
    this.mediaType,
    this.title = '',
    this.releaseDate = '',
    this.name = '',
    this.firstAirDate = '',
  });

  factory TrendingModel.fromJson(Map<String, dynamic> json) {
    final getBackDropPath = stringHelper(json['backdrop_path']);

    final getPosterPath = stringHelper(json['poster_path']);

    return TrendingModel(
      overview: json['overview'],
      releaseDate: json['release_date'],
      backdropPath: getBackDropPath,
      voteCount: json['vote_count'],
      originalLanguage: json['original_language'],
      id: json['id'],
      posterPath: getPosterPath,
      title: json['title'],
      voteAverage: json['vote_average'],
      popularity: json['popularity'],
      mediaType: json['media_type'],
      name: json['name'],
      firstAirDate: json['first_air_date'],
    );
  }
}

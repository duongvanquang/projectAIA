import '../helper/string_helper.dart';

class Movie {
  final int id;
  final bool? adult;
  final String? backdropPath;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final String? voteAverage;
  final int? voteCount;

  Movie({
    required this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final getBackDropPath = stringHelper(json['backdrop_path']);
    final getPosterPath = stringHelper(json['poster_path']);
    return Movie(
        id: json['id'],
        adult: json['adult'],
        backdropPath: getBackDropPath,
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'].toString(),
        posterPath: getPosterPath,
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toString(),
        voteCount: json['vote_count']);
  }

  String images(String backdropPath, String baseUrl, int backdropSizes) =>
      '$baseUrl/t/p$backdropSizes$backdropPath';
}

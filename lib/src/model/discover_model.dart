import '../helper/iterable_helper.dart';

import '../helper/string_helper.dart';

class DiscoverModel {
  final String? backdropPath;
  final String? firstAirDate;
  final List<dynamic>? genreIds;
  final int? id;
  final String? name;
  final List<dynamic>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final num? popularity;
  final String? posterPath;

  final int? voteCount;

  DiscoverModel(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteCount});

  factory DiscoverModel.fromJson(Map<String, dynamic> json) {
    final getBackdropPath = stringHelper(json['backdrop_path']);
    final getFirstAirDate = stringHelper(json['first_air_date']);
    final getGenreIds = iterableHelpers(json['genre_ids']);
    final getName = stringHelper(json['name']);
    final getOriginCountry = iterableHelpers(json['origin_country']);
    final getOriginalLanguage = stringHelper(json['original_language']);
    final getOriginalName = stringHelper(json['original_name']);
    final getOverview = stringHelper(json['overview']);
    final getPosterPath = stringHelper(json['poster_path']);
    var getId = 0;
    if (json['id'] != null) {
      getId = json['id'];
    }
    var getVoteCount = 0;
    if (json['vote_count'] != null) {
      getVoteCount = json['vote_count'];
    }

    return DiscoverModel(
      backdropPath: getBackdropPath,
      firstAirDate: getFirstAirDate,
      genreIds: getGenreIds as dynamic,
      id: getId,
      name: getName,
      originCountry: getOriginCountry as dynamic,
      originalLanguage: getOriginalLanguage,
      originalName: getOriginalName,
      overview: getOverview,
      popularity: json['popularity'] ?? 0.0,
      posterPath: getPosterPath,
      voteCount: getVoteCount,
    );
  }
}

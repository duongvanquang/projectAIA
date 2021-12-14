import '../helper/iterable_helper.dart';

import '../helper/string_helper.dart';

class CreditModel {
  final String? backdropPath;
  final String? firstAirDate;
  final List<dynamic>? genreIds;
  final int? id;
  final String? title;
  final List<dynamic>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final double voteAverage;
  final int? voteCount;
  final double? popularity;
  final String? character;
  final String? creditId;
  final int? episodeCount;
  const CreditModel(
      {required this.voteAverage,
      this.backdropPath,
      this.character,
      this.creditId,
      this.episodeCount,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.title,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteCount});
  factory CreditModel.fromJson(Map<String, dynamic> json) {
    final getBackdropPath = stringHelper(json['backdrop_path']);
    final getFirstAirDate = stringHelper(json['first_air_date']);
    final getGenreIds = iterableHelpers(json['genre_ids']);
    final getTitle = stringHelper(json['title']);
    final getOriginCountry = iterableHelpers(json['origin_country']);
    final getOriginalLanguage = stringHelper(json['original_language']);
    final getOriginalName = stringHelper(json['original_name']);
    final getOverview = stringHelper(json['overview']);
    final getPosterPath = stringHelper(json['poster_path']);
    final getCreditId = stringHelper(json['credit_id']);
    final getCharacter = stringHelper(json['character']);
    var getId = 0;
    if (json['id'] != null) {
      getId = json['id'];
    }
    var getVoteAverage = 0.0;
    if (json['vote_average'] != null) {
      getVoteAverage = json['vote_average'];
    }
    var getVoteCount = 0;
    if (json['vote_count'] != null) {
      getVoteCount = json['vote_count'];
    }
    var getPopularity = 0.0;
    if (json['popularity'] != null) {
      getPopularity = json['popularity'];
    }

    var getEpisodeCount = 0;
    if (json['episode_count'] != null) {
      getEpisodeCount = json['episode_count'];
    }
    return CreditModel(
        backdropPath: getBackdropPath,
        firstAirDate: getFirstAirDate,
        genreIds: getGenreIds as dynamic,
        id: getId,
        title: getTitle,
        originCountry: getOriginCountry as dynamic,
        originalLanguage: getOriginalLanguage,
        originalName: getOriginalName,
        overview: getOverview,
        posterPath: getPosterPath,
        voteAverage: getVoteAverage,
        voteCount: getVoteCount,
        popularity: getPopularity,
        character: getCharacter,
        creditId: getCreditId,
        episodeCount: getEpisodeCount);
  }
}

import '../helper/iterable_helper.dart';
import '../helper/string_helper.dart';

class SearchModel {
  final String? backdropPath;
  final String? firstAirDate;
  final List<dynamic>? genreIds;
  final int? id;
  final String? mediaType;
  final String? name;
  final String? profilePath;
  final List<dynamic>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final dynamic voteAverage;
  final int? voteCount;
  final bool? adult;
  final String? originalTitle;
  final String? releaseDate;
  final String? title;
  final String? character;
  final bool? video;
  SearchModel(
      {required this.voteAverage,
      this.profilePath,
      this.adult,
      this.character,
      this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.mediaType,
      this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteCount});
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final getMediaType = stringHelper(json['media_type']);
    final getBackdropPath = stringHelper(json['backdrop_path']);
    final getFirstAirDate = stringHelper(json['first_air_date']);
    final getGenreIds = iterableHelpers(json['genre_ids']);
    final getTitle = stringHelper(json['title']);
    final getOriginCountry = iterableHelpers(json['origin_country']);
    final getOriginalLanguage = stringHelper(json['original_language']);
    final getOriginalName = stringHelper(json['original_name']);
    final getOverview = stringHelper(json['overview']);
    final getPosterPath = stringHelper(json['poster_path']);
    final getOriginalTitle = stringHelper(json['original_title']);
    final getReleaseDate = stringHelper(json['release_date']);
    final getProfilePath = stringHelper(json['profile_path']);
    final getCharacter = stringHelper(json['character']);
    var getId = 0;
    if (json['id'] != null) {
      getId = json['id'];
    }
    var getVoteCount = 0;
    if (json['vote_count'] != null) {
      getVoteCount = json['vote_count'];
    }
    var getPopularity = 0.0;
    if (json['popularity'] != null) {
      getPopularity = json['popularity'];
    }

    return SearchModel(
        character: getCharacter,
        mediaType: getMediaType,
        backdropPath: getBackdropPath,
        firstAirDate: getFirstAirDate,
        genreIds: getGenreIds as dynamic,
        title: getTitle,
        originCountry: getOriginCountry as dynamic,
        originalLanguage: getOriginalLanguage,
        originalName: getOriginalName,
        overview: getOverview,
        posterPath: getPosterPath,
        id: getId,
        profilePath: getProfilePath,
        popularity: getPopularity,
        voteAverage: json['vote_average'],
        originalTitle: getOriginalTitle,
        releaseDate: getReleaseDate,
        video: json['video'],
        adult: json['adult'],
        voteCount: getVoteCount);
  }
}

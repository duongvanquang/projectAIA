import '../helper/iterable_helper.dart';
import '../helper/string_helper.dart';
import 'cast_model.dart';
import 'review_model.dart';
import 'trailer_model.dart';

class DetailTvModel {
  final String? backdropPath;
  final String? homepage;
  final int? id;
  final String? lastAirDate;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<dynamic>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? status;
  final String? tagline;
  final String? type;
  final double voteAverage;
  final int? voteCount;
  List<CastModel>? castmodel;
  List<ReviewModel>? reviewmodel;
  List<TrailerModel>? trailerModel;
  DetailTvModel(
      {required this.voteAverage,
      this.homepage,
      this.trailerModel,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.status,
      this.tagline,
      this.type,
      this.voteCount,
      this.id,
      this.backdropPath,
      this.lastAirDate,
      this.castmodel,
      this.reviewmodel,
      this.name});
  factory DetailTvModel.fromJson(Map<String, dynamic> json) {
    final getBackdropPath = stringHelper(json['backdrop_path']);
    final getPosterPath = stringHelper(json['poster_path']);
    final getHomepage = stringHelper(json['homepage']);
    final getLastAirDate = stringHelper(json['last_air_date']);
    final getName = stringHelper(json['name']);
    final getOriginCountry = iterableHelpers(json['origin_country']);
    final getOriginalLanguage = stringHelper(json['original_language']);
    final getOriginalName = stringHelper(json['original_name']);
    final getOverview = stringHelper(json['overview']);
    final getStatus = stringHelper(json['status']);
    final getTagline = stringHelper(json['tagline']);
    final getType = stringHelper(json['type']);
    var getId = 0;
    if (json['id'] != null) {
      getId = json['id'];
    }
    var getPopularity = 0.0;
    if (json['popularity'] != null) {
      getPopularity = json['popularity'];
    }
    var getNumberOfEpisodes = 0;
    if (json['number_of_episodes'] != null) {
      getNumberOfEpisodes = json['number_of_episodes'];
    }
    var getNumberOfSeasons = 0;
    if (json['number_of_seasons'] != null) {
      getNumberOfSeasons = json['number_of_seasons'];
    }
    var getVoteAverage = 0.0;
    if (json['vote_average'] != null) {
      getVoteAverage = json['vote_average'];
    }
    var getVoteCount = 0;
    if (json['vote_count'] != null) {
      getVoteCount = json['vote_count'];
    }

    return DetailTvModel(
        backdropPath: getBackdropPath,
        posterPath: getPosterPath,
        homepage: getHomepage,
        id: getId,
        lastAirDate: getLastAirDate,
        name: getName,
        originCountry: getOriginCountry as dynamic,
        originalLanguage: getOriginalLanguage,
        originalName: getOriginalName,
        overview: getOverview,
        popularity: getPopularity,
        numberOfEpisodes: getNumberOfEpisodes,
        numberOfSeasons: getNumberOfSeasons,
        status: getStatus,
        tagline: getTagline,
        type: getType,
        voteAverage: getVoteAverage,
        voteCount: getVoteCount);
  }
}

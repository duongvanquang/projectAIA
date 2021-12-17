import '../helper/string_helper.dart';

class TrailerModel {
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final String? type;
  final bool? official;
  final String? publishedAt;
  final String? id;
  TrailerModel(
      {this.iso6391,
      this.iso31661,
      this.name,
      this.key,
      this.site,
      this.type,
      this.official,
      this.publishedAt,
      this.id});
  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    final getIso6391 = stringHelper(json['iso_639_1']);
    final getIso31661 = stringHelper(json['iso_3166_1']);
    final getName = stringHelper(json['name']);
    final getKey = stringHelper(json['key']);
    final getSite = stringHelper(json['site']);
    final getType = stringHelper(json['type']);
    final getPublishedAt = stringHelper(json['published_at']);
    final getId = stringHelper(json['id']);
    return TrailerModel(
      iso6391: getIso6391,
      iso31661: getIso31661,
      name: getName,
      key: getKey,
      site: getSite,
      type: getType,
      official: json['official'],
      publishedAt: getPublishedAt,
      id: getId,
    );
  }
}

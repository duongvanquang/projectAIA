import '../helper/string_helper.dart';

class CastModel {
  final String? name;
  final int? id;
  final String? profilePath;
  final String? character;
  CastModel({
    required this.id,
    this.name,
    this.profilePath,
    this.character,
  });
  factory CastModel.fromJson(Map<String, dynamic> json) {
    final getName = stringHelper(json['name']);
    final getCharacter = stringHelper(json['character']);
    final getBackDropPath = stringHelper(json['profile_path']);

    var getId = 0;

    if (json['id'] != null) {
      getId = json['id'];
    }
    return CastModel(
        id: getId,
        name: getName,
        character: getCharacter,
        profilePath: getBackDropPath);
  }
}

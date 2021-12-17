import '../helper/string_helper.dart';

class ReviewModel {
  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final String? createdAt;
  final String? updatedAt;
  final String? url;
  ReviewModel(
      {this.author,
      this.authorDetails,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.url});
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final getAuthor = stringHelper(json['author']);
    final getContent = stringHelper(json['content']);
    final getCreatedAt = stringHelper(json['created_at']);
    final getUpdatedAt = stringHelper(json['updated_at']);
    final getUrl = stringHelper(json['url']);
    return ReviewModel(
        author: getAuthor,
        content: getContent,
        createdAt: getCreatedAt,
        updatedAt: getUpdatedAt,
        authorDetails: AuthorDetails.fromJson(json['author_details']),
        url: getUrl);
  }
}

class AuthorDetails {
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;
  AuthorDetails({this.name, this.username, this.avatarPath, this.rating});
  factory AuthorDetails.fromJson(Map<String, dynamic> json) {
    final getName = stringHelper(json['name']);
    final getUsername = stringHelper(json['username']);
    final getAvatarPath = stringHelper(json['avatar_path']);

    // if (json['rating'] != null) {
    //   getRating = json['rating'];
    // }
    return AuthorDetails(
        name: getName,
        username: getUsername,
        avatarPath: getAvatarPath,
        rating: json['rating'] ?? 0.0);
  }
}

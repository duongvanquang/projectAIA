class PersonImage {
  double? aspectRatio;
  int? height;
  String? filePath;
  String? voteAverage;
  int? voteCount;
  int? width;
  PersonImage(
      {this.aspectRatio,
      this.height,
      this.filePath,
      this.voteAverage,
      this.voteCount,
      this.width});
  PersonImage.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'].toString();
    voteCount = json['vote_count'];
    width = json['width'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aspect_ratio'] = aspectRatio;
    data['height'] = height;
    data['file_path'] = filePath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['width'] = width;
    return data;
  }
}

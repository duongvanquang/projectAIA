import 'package:easy_localization/easy_localization.dart';

class Section {
  final String title;
  final String genreType;
  final String image;
  Section({required this.title, required this.image, required this.genreType});
}

List<Section> genresSection = [
  Section(
      image: tr('genres.imageSciTV'),
      title: tr('genres.genresadventure'),
      genreType: tr('genres.nowplaying')),
  Section(
      image: tr('genres.imageAnimationTV'),
      title: tr(
        'genres.genresanimation',
      ),
      genreType: tr('genres.popular')),
  Section(
      image: tr('genres.imagecomdy'),
      title: tr('genres.genresdrama'),
      genreType: tr('genres.toprated')),
  Section(
      image: tr('genres.imageromance'),
      title: tr('genres.upcoming'),
      genreType: tr('genres.upcoming'))
];

import 'package:easy_localization/easy_localization.dart';

class Section {
  final String title;
  final String genreType;
  final String image;
  Section({required this.title, required this.image, required this.genreType});
}

List<Section> genresSection = [
  Section(
      image: tr('genresscreen.imageSciTV'),
      title: tr('genresscreen.genresadventure'),
      genreType: tr('genresscreen.nowplaying')),
  Section(
      image: tr('genresscreen.imageAnimationTV'),
      title: tr(
        'genresscreen.genresanimation',
      ),
      genreType: tr('genresscreen.popular')),
  Section(
      image: tr('genresscreen.imagecomdy'),
      title: tr('genresscreen.genresdrama'),
      genreType: tr('genresscreen.toprated')),
  Section(
      image: tr('genresscreen.imageromance'),
      title: tr('genresscreen.upcoming'),
      genreType: tr('genresscreen.upcoming'))
];

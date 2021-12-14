import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../model/section_model.dart';
import '../theme/color_theme.dart';
import '../widgtes/custom_header.dart';
import '../widgtes/section_genres.dart';

class GenresScreen extends StatelessWidget {
  const GenresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 200),
          child: CustomHeader(title: tr('genresscreen.headertitle')),
        ),
        body: Container(
          color: ColorsTheme.secondaryGrey,
          child: ListView.builder(
              itemCount: genresSection.length,
              itemBuilder: (context, index) {
                final item = genresSection[index];
                return SectionGenres(
                  genreType: item.genreType,
                  image: item.image,
                  title: item.title,
                );
              }),
        ),
      ));
}

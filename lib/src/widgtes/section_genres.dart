import 'package:flutter/material.dart';

import '../app_dependencies.dart';
import '../blocs/genres/genres_bloc.dart';
import '../blocs/genres/genres_event.dart';
import '../screens/detail_genrestype_screen.dart';
import '../theme/color_theme.dart';

class SectionGenres extends StatelessWidget {
  final String? title;
  final String? image;
  final String? genreType;
  const SectionGenres({
    required this.title,
    required this.image,
    required this.genreType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DetailGenresTypeScreen(
                    title: title,
                    image: image,
                    genreType: genreType,
                  )),
        );

        AppDependencies.injector
            .get<GenresBloc>()
            .add(GenresSectionStartted(genreType: genreType!));
      },
      child: Stack(
        children: [
          Card(
            child: Image(
              image: AssetImage('assets/images/$image.png'),
              height: 250,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: h / 5,
            child: Container(
              height: 100,
              width: 500,
              color: ColorsTheme.secondaryGrey.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Text(
                  title!,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: ColorsTheme.primaryBlack),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

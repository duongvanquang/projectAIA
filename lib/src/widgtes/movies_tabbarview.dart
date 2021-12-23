import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/person_id/personid_bloc.dart';
import '../blocs/person_id/personid_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';
import 'rating_widget.dart';

class MoviesTabbarView extends StatelessWidget {
  const MoviesTabbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: ColorsTheme.secondaryGrey,
      body: BlocBuilder<PersonidBloc, PersonidState>(
        bloc: AppDependencies.injector.get<PersonidBloc>(),
        builder: (context, state) {
          if (state is PersonIdLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PersonIdLoadInSuccess) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.personId.creditCart!.length,
                itemBuilder: (context, index) {
                  final item = state.personId.creditCart![index];
                  final convertRatingToFiveUnits = item.voteAverage / 2;
                  return SizedBox(
                    height: 280,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: const EdgeInsets.all(6),
                      child: BlocBuilder<ConfigurationBloc, ConfigurationState>(
                        bloc: AppDependencies.injector.get<ConfigurationBloc>(),
                        builder: (context, state) {
                          if (state is ConfigurationStartSuccess) {
                            return Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      '''${state.configurationModel.getPosterSize(PosterSize.small)}${item.posterPath}''',
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: SizedBox(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/img_not_found.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(item.title!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3!
                                                      .copyWith(
                                                          color: ColorsTheme
                                                              .secondaryGrey),
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1),
                                            ),
                                          ),
                                          Text(item.character!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(
                                                      color: ColorsTheme
                                                          .secondaryGrey))
                                        ],
                                      ),
                                      const Spacer(),
                                      StarRating(
                                        rating: convertRatingToFiveUnits,
                                        color: ColorsTheme.yellowRatingColor,
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(height: 15),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  );
                });
          }
          return const SizedBox.shrink();
        },
      ));
}

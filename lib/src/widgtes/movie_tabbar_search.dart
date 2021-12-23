import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';
import 'rating_widget.dart';

class MovieTabbarSearch extends StatefulWidget {
  const MovieTabbarSearch({Key? key}) : super(key: key);

  @override
  State<MovieTabbarSearch> createState() => _MovieTabbarSearchState();
}

class _MovieTabbarSearchState extends State<MovieTabbarSearch> {
  @override
  Widget build(BuildContext context) => BlocBuilder<SearchBloc, SearchState>(
        bloc: AppDependencies.injector.get<SearchBloc>(),
        builder: (context, state) {
          if (state is SearchLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SearchLoaInSuccess) {
            final items = state.searchData
                .where((element) => element.mediaType == 'movie')
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final convertRatingToFiveUnits = items[index].voteAverage / 2;
                  final itemdataSearch = items[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        BlocBuilder<ConfigurationBloc, ConfigurationState>(
                          bloc:
                              AppDependencies.injector.get<ConfigurationBloc>(),
                          builder: (context, state) {
                            if (state is ConfigurationStartSuccess) {
                              return CachedNetworkImage(
                                imageUrl:
                                    '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${itemdataSearch.posterPath}''',
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/img_not_found.png',
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(itemdataSearch.mediaType!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color: ColorsTheme
                                                      .secondaryGrey),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Text(itemdataSearch.title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color:
                                                    ColorsTheme.secondaryGrey),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1),
                                  )
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
                      ],
                    ),
                  );
                });
          }
          return const SizedBox.shrink();
        },
      );
}

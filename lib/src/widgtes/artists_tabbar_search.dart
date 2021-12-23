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

class ArtistsTabbarSearch extends StatefulWidget {
  const ArtistsTabbarSearch({Key? key}) : super(key: key);

  @override
  State<ArtistsTabbarSearch> createState() => _ArtistsTabbarSearchState();
}

class _ArtistsTabbarSearchState extends State<ArtistsTabbarSearch> {
  @override
  Widget build(BuildContext context) => BlocBuilder<SearchBloc, SearchState>(
        bloc: AppDependencies.injector.get<SearchBloc>(),
        builder: (context, state) {
          if (state is SearchLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaInSuccess) {
            final items = state.searchData
                .where((element) => element.mediaType == 'person')
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
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
                                    '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${itemdataSearch.profilePath}''',
                                width: double.infinity,
                                height: 180,
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
                          child: SizedBox(
                            width: 200,
                            child: Text(itemdataSearch.mediaType!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: ColorsTheme.secondaryGrey),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 1),
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

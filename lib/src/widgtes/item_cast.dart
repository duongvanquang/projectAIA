import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_event.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/detail_movie/detailmovie_bloc.dart';
import '../blocs/detail_movie/detailmovie_state.dart';

import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';

class ItemCast extends StatelessWidget {
  const ItemCast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDependencies.injector
        .get<ConfigurationBloc>()
        .add(ConfigurationStarted());
    return Scaffold(
      backgroundColor: ColorsTheme.secondaryGrey,
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        bloc: AppDependencies.injector.get<DetailMovieBloc>(),
        builder: (context, state) {
          if (state is DetailMovieLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailMovieLoadInSuccess) {
            return GridView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: 0.5),
              itemCount: state.detailMovieModel.castmodel!.length,
              itemBuilder: (context, index) {
                final item = state.detailMovieModel.castmodel![index];
                return BlocBuilder<ConfigurationBloc, ConfigurationState>(
                  bloc: AppDependencies.injector.get<ConfigurationBloc>(),
                  builder: (context, state) {
                    if (state is ConfigurationStartSuccess) {
                      return SizedBox(
                        height: 250,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 5,
                            margin: const EdgeInsets.all(5),
                            child: Column(children: [
                              CachedNetworkImage(
                                imageUrl:
                                    '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${item.profilePath}''',
                                height: 180,
                                width: double.infinity,
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
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                width: 150,
                                child: Text(item.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: ColorsTheme.primaryBlack),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              )
                            ])),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

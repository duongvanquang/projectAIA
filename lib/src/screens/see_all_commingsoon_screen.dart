import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesaia/src/app_dependencies.dart';

import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/discover/discover_bloc.dart';
import '../blocs/discover/discover_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';

class SeeAllTvScreen extends StatelessWidget {
  const SeeAllTvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: Text(
            'See All',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: ColorsTheme.primaryBlack),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 32,
                color: Colors.blue,
              ))),
      body: Container(
        color: ColorsTheme.secondaryGrey,
        child: BlocBuilder<DiscoverBloc, DiscoverState>(
            bloc: AppDependencies.injector.get<DiscoverBloc>(),
            builder: (context, state) {
              if (state is DiscoverLoadInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DiscoverLoadSuccess) {
                return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.4,
                            mainAxisSpacing: 0.5),
                    itemCount: state.commingsoon.length,
                    itemBuilder: (context, index) {
                      final item = state.commingsoon[index];
                      return BlocBuilder<ConfigurationBloc, ConfigurationState>(
                        bloc: AppDependencies.injector.get<ConfigurationBloc>(),
                        builder: (context, state) {
                          if (state is ConfigurationStartSuccess) {
                            return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                margin: const EdgeInsets.all(5),
                                child: Column(children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${item.posterPath}''',
                                    height: 250,
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
                                  const SizedBox(height: 18),
                                  SizedBox(
                                    width: 150,
                                    child: Text(item.title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color:
                                                    ColorsTheme.primaryBlack),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2),
                                  )
                                ]));
                          }

                          return const SizedBox.shrink();
                        },
                      );
                    });
              }
              return const SizedBox.shrink();
            }),
      ));
}

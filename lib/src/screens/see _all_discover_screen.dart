import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/discover/discover_bloc.dart';
import '../blocs/discover/discover_event.dart';
import '../blocs/discover/discover_state.dart';
import '../model/movies_configuration.dart';
import '../route_name/route_name.dart';
import '../theme/color_theme.dart';

class SeeAllMovieScreen extends StatefulWidget {
  const SeeAllMovieScreen({Key? key}) : super(key: key);

  @override
  State<SeeAllMovieScreen> createState() => _SeeAllMovieScreenState();
}

class _SeeAllMovieScreenState extends State<SeeAllMovieScreen> {
  late ScrollController _controllerpage;
  int _nextpage = 1;
  final _discoverBloc = AppDependencies.injector.get<DiscoverBloc>();
  void _loadmore() {
    if (_controllerpage.position.pixels ==
        _controllerpage.position.maxScrollExtent) {
      _nextpage++;
      _discoverBloc.add(
        LoadMorePageDatated(nextpage: _nextpage),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerpage = ScrollController()..addListener(_loadmore);
  }

  @override
  void dispose() {
    _controllerpage.removeListener(_loadmore);
    super.dispose();
  }

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
                    controller: _controllerpage,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.4,
                            mainAxisSpacing: 0.5),
                    itemCount: state.discoverdata.length,
                    itemBuilder: (context, index) {
                      final item = state.discoverdata[index];
                      return BlocBuilder<ConfigurationBloc, ConfigurationState>(
                        bloc: AppDependencies.injector.get<ConfigurationBloc>(),
                        builder: (context, state) {
                          if (state is ConfigurationStartSuccess) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RouteName.detailTv,
                                    arguments: {'id': item.id});
                              },
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
                                          '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${item.posterPath}''',
                                      height: 250,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: SizedBox(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
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
                                      child: Text(item.name!,
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
                                  ])),
                            );
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_event.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/detail_tv/detail_bloc.dart';
import '../blocs/detail_tv/detail_event.dart';
import '../model/discover_model.dart';
import '../model/movies_configuration.dart';
import '../route_name/route_name.dart';
import '../theme/color_theme.dart';

class ItemCommingsoon extends StatefulWidget {
  final DiscoverModel? discoverData;

  const ItemCommingsoon({required this.discoverData, Key? key})
      : super(key: key);

  @override
  State<ItemCommingsoon> createState() => _ItemCommingsoonState();
}

class _ItemCommingsoonState extends State<ItemCommingsoon> {
  @override
  void initState() {
    AppDependencies.injector
        .get<ConfigurationBloc>()
        .add(ConfigurationStarted());
    AppDependencies.injector
        .get<DetailBloc>()
        .add(DetailCoomingSoonStartted(id: widget.discoverData!.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ConfigurationBloc, ConfigurationState>(
        bloc: AppDependencies.injector.get<ConfigurationBloc>(),
        builder: (context, state) {
          if (state is ConfigurationStartSuccess) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.detailTv,
                    arguments: {'id': widget.discoverData!.id!});
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5,
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          '''${state.configurationModel.getPosterSize(PosterSize.small)}${widget.discoverData!.posterPath}''',
                      height: 250,
                      width: 200,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/img_not_found.jpg'),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: SizedBox(
                        width: 150,
                        child: Text('${widget.discoverData!.name}',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: ColorsTheme.secondaryGrey),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                      ),
                    ),
                    // SizedBox(height: 15),
                    Text(
                      '${widget.discoverData!.firstAirDate}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: ColorsTheme.secondaryGrey),
                    )
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      );
}

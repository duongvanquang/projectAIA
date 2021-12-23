import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesaia/src/app_dependencies.dart';

import '../blocs/discover/discover_bloc.dart';
import '../blocs/discover/discover_event.dart';
import '../blocs/discover/discover_state.dart';
import '../route_name/route_name.dart';
import '../theme/color_theme.dart';
import '../widgtes/custom_header.dart';
import '../widgtes/custom_seeall.dart';
import '../widgtes/item_comminngsoon.dart';
import '../widgtes/item_popular.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _discoverBloc = AppDependencies.injector.get<DiscoverBloc>()
    ..add(DiscoverStartted());

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 200),
            child: CustomHeader(title: tr('discover.headertitle')),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<DiscoverBloc, DiscoverState>(
                  bloc: _discoverBloc,
                  builder: (context, state) {
                    if (state is DiscoverLoadInProgress) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DiscoverLoadSuccess) {
                      return Container(
                        color: ColorsTheme.secondaryGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RouteName.seeAllDiscoverData);
                                    },
                                    child: CustomSeeAll(
                                      title: tr('discover.popular'),
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 350,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const ScrollPhysics(),
                                    itemCount: state.commingsoon.length,
                                    itemBuilder: (context, index) {
                                      final item = state.commingsoon[index];
                                      return ItemPopular(movie: item);
                                    }),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RouteName.seeAllCommingSoonData);
                                    },
                                    child: CustomSeeAll(
                                      title: tr('discover.commingsoon'),
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 350,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const ScrollPhysics(),
                                    itemCount: state.discoverdata.length,
                                    itemBuilder: (context, index) {
                                      final item = state.discoverdata[index];
                                      return ItemCommingsoon(
                                        discoverData: item,
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      );
}

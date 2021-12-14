import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/discover/discover_bloc.dart';
import '../blocs/discover/discover_event.dart';
import '../blocs/discover/discover_state.dart';
import '../theme/color_theme.dart';
import '../widgtes/custom_header.dart';
import '../widgtes/custom_seeall.dart';
import '../widgtes/item_comminngsoon.dart';
import '../widgtes/item_popular.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DiscoverBloc>().add(DiscoverStartted());
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 200),
          child: CustomHeader(title: tr('discoverscreen.headertitle')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<DiscoverBloc, DiscoverState>(
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
                            Text(
                              tr('discoverscreen.popular'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: ColorsTheme.primaryBlack),
                            ),
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
                                child: CustomSeeAll(
                                  title: tr('discoverscreen.commingsoon'),
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
}

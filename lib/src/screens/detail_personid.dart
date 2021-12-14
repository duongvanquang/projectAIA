import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/personid/personid_bloc.dart';
import '../blocs/personid/personid_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';
import '../widgtes/custom_tabbar_view.dart';
import '../widgtes/more_tabbarview.dart';
import '../widgtes/movies_tabbarview.dart';
import '../widgtes/summary_tabbarview.dart';

class DetailPersonIdScreen extends StatelessWidget {
  const DetailPersonIdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<PersonidBloc, PersonidState>(
        builder: (context, state) {
          if (state is PersonIdLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonIdLoadInSuccess) {
            final detailperson = state.personId;
            return Column(
              children: [
                Stack(alignment: Alignment.bottomCenter, children: [
                  BlocBuilder<ConfigurationBloc, ConfigurationState>(
                    builder: (context, state) {
                      if (state is ConfigurationStartSuccess) {
                        return CachedNetworkImage(
                          imageUrl:
                              '''${state.configurationModel.getBackdropSizes(BackdropSize.medium)}${detailperson.profilePath}''',
                          height: 500,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/img_not_found.png'),
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Positioned(
                      top: h / 4,
                      left: w / 12,
                      child: Text(
                        detailperson.name!,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: ColorsTheme.primaryWhite),
                      )),
                  Positioned(
                      top: h / 3.3,
                      left: w / 8,
                      child: Text(
                        detailperson.popularity.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: ColorsTheme.primaryWhite),
                      )),
                  Positioned(
                      top: h / 15,
                      left: w / 40,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.navigate_before,
                            size: 40, color: ColorsTheme.primaryWhite),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BlocBuilder<ConfigurationBloc, ConfigurationState>(
                        builder: (context, state) => SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const ScrollPhysics(),
                                  itemCount: detailperson.personImage!.length,
                                  itemBuilder: (context, index) {
                                    final itemImage =
                                        detailperson.personImage![index];
                                    return BlocBuilder<ConfigurationBloc,
                                        ConfigurationState>(
                                      builder: (context, state) {
                                        if (state
                                            is ConfigurationStartSuccess) {
                                          return Card(
                                              child: CachedNetworkImage(
                                            imageUrl:
                                                '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${itemImage.filePath}''',
                                            height: 100,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/img_not_found.png'),
                                                ),
                                              ),
                                            ),
                                          ));
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    );
                                  }),
                            )),
                  ),
                ]),
                const Expanded(
                    child: TabbarView(
                  firtTabbar: 'Summary',
                  secondTabbar: 'Movies',
                  lastTabbar: 'More',
                  firtTabbarView: SummaryTabbarView(),
                  secondTabbarView: MoviesTabbarView(),
                  lastTabbarView: MoreTabbarView(),
                ))
              ],
            );
          }

          return Stack();
        },
      ),
    );
  }
}

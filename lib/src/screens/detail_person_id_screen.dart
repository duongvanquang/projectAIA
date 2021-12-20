import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/person_id/personid_bloc.dart';
import '../blocs/person_id/personid_state.dart';
import '../constants/api_constants.dart';
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
                      top: h / 3.5,
                      left: w / 12,
                      child: Text(
                        detailperson.name!,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: ColorsTheme.primaryWhite),
                      )),
                  Positioned(
                      top: h / 2.9,
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
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            child: Image(
                                color: ColorsTheme.blueColor.withOpacity(0.6),
                                image: NetworkImage(ApiConstant.baseImage +
                                    detailperson.profilePath!)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/image_photo');
                            },
                            child: Row(
                              children: [
                                Text(
                                  detailperson.personImage!.length.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color: ColorsTheme.primaryWhite),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '+',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color: ColorsTheme.primaryWhite),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 150,
                        child: Image(
                            image: NetworkImage(ApiConstant.baseImage +
                                detailperson.personImage![0].filePath!)),
                      ),
                      Expanded(
                        child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent:
                                        (state.personId.personImage?.length ??
                                                    0) <=
                                                2
                                            ? 150
                                            : 75),
                            itemCount:
                                state.personId.personImage?.take(4).length ?? 0,
                            itemBuilder: (context, index) {
                              final itemImage =
                                  detailperson.personImage![index];
                              return BlocBuilder<ConfigurationBloc,
                                  ConfigurationState>(
                                builder: (context, state) {
                                  if (state is ConfigurationStartSuccess) {
                                    return CachedNetworkImage(
                                      imageUrl:
                                          '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${itemImage.filePath}''',
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Container(
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
                              );
                            }),
                      ),
                    ],
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_event.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/detail/detailtv_bloc.dart';
import '../blocs/detail/detailtv_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';
import '../widgtes/custom_tabbar_view.dart';
import '../widgtes/more_tabbarview.dart';
import '../widgtes/rating_widget.dart';
import '../widgtes/summary_tabbarview.dart';
import 'artists_screen.dart';

class DetailTvScreen extends StatelessWidget {
  const DetailTvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ConfigurationBloc>().add(ConfigurationStarted());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, size: 32)),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite, size: 32))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<DetailtvBloc, DetailtvState>(
        builder: (context, state) {
          if (state is DetailTvLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTvLoadInSuccess) {
            final item = state.detailTvModel;
            final convertRatingToFiveUnits = item.voteAverage / 2;
            return BlocBuilder<ConfigurationBloc, ConfigurationState>(
              builder: (context, state) {
                if (state is ConfigurationStartSuccess) {
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) => const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorsTheme.primaryWhite,
                                Colors.transparent,
                              ],
                            ).createShader(Rect.fromLTRB(0, 0, 0, rect.bottom)),
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              imageUrl:
                                  '''${state.configurationModel.getPosterSize(PosterSize.medium)}${item.posterPath}''',
                              height: 400,
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
                                        'assets/images/img_not_found.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.play_circle_outline_sharp,
                                  size: 50, color: Colors.white))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '''${state.configurationModel.getPosterSize(PosterSize.medium)}${item.posterPath}''',
                              height: 180,
                              width: 150,
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
                                        'assets/images/img_not_found.png'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('The Best of Me',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                              color: ColorsTheme.primaryBlack)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: const [
                                      Text('Ac tion'),
                                      Text('Drama'),
                                      Text('Advanture')
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      StarRating(
                                        rating: convertRatingToFiveUnits,
                                        color: ColorsTheme.yellowRatingColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Text('${item.voteAverage} / 10',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color:
                                                      ColorsTheme.primaryBlack))
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Text('Languge : ${item.originalLanguage}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: ColorsTheme.primaryBlack)),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${item.popularity}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: ColorsTheme.primaryBlack),
                                  )
                                ])
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          item.overview!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: ColorsTheme.primaryBlack),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Flexible(
                        child: TabbarView(
                            firtTabbar: 'Cast',
                            firtTabbarView: ArtistsScreen(),
                            lastTabbar: 'More',
                            lastTabbarView: MoreTabbarView(),
                            secondTabbar: 'Review',
                            secondTabbarView: SummaryTabbarView()),
                      )
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

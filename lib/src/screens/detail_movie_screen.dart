import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_dependencies.dart';
import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_event.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/detail_movie/detailmovie_bloc.dart';
import '../blocs/detail_movie/detailmovie_event.dart';
import '../blocs/detail_movie/detailmovie_state.dart';
import '../blocs/favorities/favorities_bloc.dart';
import '../blocs/favorities/favorities_event.dart';
import '../blocs/favorities/favorities_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';
import '../widgtes/custom_tabbar_view.dart';
import '../widgtes/item_cast.dart';
import '../widgtes/more_tabbarview.dart';
import '../widgtes/rating_widget.dart';
import '../widgtes/review_movie.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({Key? key}) : super(key: key);

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

void submitSuccess(context, state) {
  if (state is FavoritiesLoadInSuccess) {
    if (state.favoritiesSuccess) {
      Future.delayed(const Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'SubmitSuccess',
            )));
      });
    }
  }
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  Widget build(BuildContext context) {
    final _favoritiesBloc = AppDependencies.injector.get<FavoritiesBloc>();
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    AppDependencies.injector.get<DetailMovieBloc>().add(DetailStartted(
          id: arg['id'],
        ));
    final h = MediaQuery.of(context).size.height;
    AppDependencies.injector
        .get<ConfigurationBloc>()
        .add(ConfigurationStarted());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, size: 32)),
        actions: [
          BlocBuilder<DetailMovieBloc, DetailMovieState>(
            bloc: AppDependencies.injector.get<DetailMovieBloc>(),
            builder: (context, state) {
              if (state is DetailMovieLoadInSuccess) {
                final item = state.detailMovieModel;
                return BlocConsumer<FavoritiesBloc, FavoritiesState>(
                  bloc: _favoritiesBloc,
                  listener: (context, state) {
                    if (state is FavoritiesLoadInSuccess) {
                      submitSuccess(context, state);
                    }
                  },
                  builder: (context, state) => IconButton(
                      onPressed: () {
                        _favoritiesBloc.add(FavoritiesStartted(
                            userName: item.status,
                            fullName: item.originalName,
                            type: item.type,
                            imagePath: item.posterPath,
                            moviesId: item.id,
                            moviesName: item.name,
                            dataTimeCreated: item.lastAirDate));
                      },
                      icon: const Icon(Icons.favorite,
                          size: 32, color: Colors.blue)),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        bloc: AppDependencies.injector.get<DetailMovieBloc>(),
        builder: (context, state) {
          if (state is DetailMovieLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailMovieLoadInSuccess) {
            final item = state.detailMovieModel;
            final convertRatingToFiveUnits = item.voteAverage / 2;
            return BlocBuilder<ConfigurationBloc, ConfigurationState>(
              bloc: AppDependencies.injector.get<ConfigurationBloc>(),
              builder: (context, state) {
                if (state is ConfigurationStartSuccess) {
                  return SizedBox(
                    height: h,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
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
                                ).createShader(
                                    Rect.fromLTRB(0, 0, 0, rect.bottom)),
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
                                  errorWidget: (context, url, error) =>
                                      Container(
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
                                  onPressed: () async {
                                    final youtubeUrl =
                                        'https://www.youtube.com/embed/${item.trailerModel![0].key}';
                                    await launch(youtubeUrl);
                                  },
                                  icon: const Icon(
                                      Icons.play_circle_outline_sharp,
                                      size: 50,
                                      color: Colors.white))
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
                                  errorWidget: (context, url, error) =>
                                      Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('The Best of Me',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color: ColorsTheme
                                                      .primaryBlack)),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: const [
                                          Text('Action | '),
                                          Text('Drama | '),
                                          Text('Advanture')
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          StarRating(
                                            rating: convertRatingToFiveUnits,
                                            color:
                                                ColorsTheme.yellowRatingColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text('${item.voteAverage} / 10',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: ColorsTheme
                                                          .primaryBlack))
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Text('Languge : ${item.originalLanguage}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: ColorsTheme
                                                      .primaryBlack)),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${item.popularity}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color:
                                                    ColorsTheme.primaryBlack),
                                      )
                                    ])
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                item.overview!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: ColorsTheme.primaryBlack),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h / 2,
                            child: const TabbarView(
                                firtTabbar: 'Cast',
                                firtTabbarView: ItemCast(),
                                secondTabbar: 'Review',
                                secondTabbarView: ReviewMovie(),
                                lastTabbar: 'More',
                                lastTabbarView: MoreTabbarView()),
                          ),
                        ],
                      ),
                    ),
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

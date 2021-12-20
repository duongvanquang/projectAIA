import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/detail_movie/detailmovie_bloc.dart';
import '../blocs/detail_movie/detailmovie_state.dart';
import '../theme/color_theme.dart';
import 'rating_widget.dart';

class ReviewMovie extends StatelessWidget {
  const ReviewMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: ColorsTheme.secondaryGrey,
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailMovieLoadInSuccess) {
            final itemDetailData = state.detailMovieModel;
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.detailMovieModel.reviewmodel!.length,
                itemBuilder: (context, index) {
                  final item = state.detailMovieModel.reviewmodel![index];
                  final convertRatingToFiveUnits =
                      item.authorDetails!.rating! / 2;
                  return SizedBox(
                    height: 230,
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<ConfigurationBloc,
                                        ConfigurationState>(
                                    builder: (context, state) {
                                  if (state is ConfigurationStartSuccess) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl: item.authorDetails!.avatarPath
                                            .toString()
                                            .substring(1),
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SizedBox(
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator())),
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
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                                const SizedBox(width: 20),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        item.author!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color:
                                                    ColorsTheme.primaryBlack),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: 70,
                                      child: Text('${item.createdAt}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color:
                                                      ColorsTheme.primaryBlack),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                StarRating(
                                  rating: convertRatingToFiveUnits,
                                  color: ColorsTheme.yellowRatingColor,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 110, right: 20),
                            child: const Divider(
                              color: ColorsTheme.primaryBlack,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(itemDetailData.overview!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: ColorsTheme.primaryBlack),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3),
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Image(
                                    width: 20,
                                    height: 20,
                                    image: AssetImage('assets/images/Like.png'),
                                  )),
                              Text(
                                ' 1500 Like',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: ColorsTheme.blueColor),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          return const SizedBox.shrink();
        },
      ));
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/detail_tv/detail_bloc.dart';
import '../blocs/detail_tv/detail_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';
import 'rating_widget.dart';

class ReviewTV extends StatelessWidget {
  const ReviewTV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorsTheme.secondaryGrey,
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailCommingSoonLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailCommingSoonLoadInSuccess) {
              final itemCommingSoon = state.detailCommingSoon;

              return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.detailCommingSoon.reviewmodel!.length,
                  itemBuilder: (context, index) {
                    final item = state.detailCommingSoon.reviewmodel![index];
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
                                          imageUrl:
                                              '''${state.configurationModel.getProfileSizes(ProfileSize.medium)}${item.authorDetails!.avatarPath}''',
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
                                  const SizedBox(width: 10),
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
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        width: 70,
                                        child: Text('${item.createdAt}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: ColorsTheme
                                                        .primaryBlack),
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
                              margin:
                                  const EdgeInsets.only(left: 110, right: 20),
                              child: const Divider(
                                color: ColorsTheme.primaryBlack,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(itemCommingSoon.overview!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: ColorsTheme.primaryBlack),
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
                                      image:
                                          AssetImage('assets/images/Like.png'),
                                    )),
                                Text(
                                  'Like',
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
        ),
      );
}

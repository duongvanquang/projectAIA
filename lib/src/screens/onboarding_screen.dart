import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/configuration/configuration_bloc.dart';
import '../blocs/configuration/configuration_event.dart';
import '../blocs/configuration/configuration_state.dart';
import '../blocs/onboarding/onboarding_bloc.dart';
import '../blocs/onboarding/onboarding_event.dart';
import '../blocs/onboarding/onboarding_state.dart';
import '../model/movies_configuration.dart';
import '../theme/color_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

int curenindex = 0;

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController? _pageController;

  final double _viewportFraction = 1;

  double? _pageOffset = 0;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: _viewportFraction)
      ..addListener(() {
        setState(() {
          _pageOffset = _pageController!.page;
        });
      });
    context.read<ConfigurationBloc>().add(ConfigurationStarted());
    context.read<OnboardingBloc>().add(OnboardingStartted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
            if (state is OnboardingLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OnboardingLoadSuccess) {
              return PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      curenindex = index;
                    });
                  },
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final item = state.trendingModel[index];
                    var angle = (_pageOffset! - index).abs();
                    if (angle > 0.7) {
                      angle = 1 - angle;
                    }
                    return SizedBox(
                      width: w,
                      height: h,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(
                            3,
                            2,
                            0.003,
                          )
                          ..rotateY(angle),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            BlocBuilder<ConfigurationBloc, ConfigurationState>(
                              builder: (context, state) {
                                if (state is ConfigurationStartSuccess) {
                                  return CachedNetworkImage(
                                    imageUrl:
                                        '''${state.configurationModel.getBackdropSizes(BackdropSize.medium)}${item.backdropPath}''',
                                    height: h,
                                    width: w,
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
                                          image: AssetImage(
                                              'assets/images/img_not_found.jpg'),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const SizedBox.shrink();
          }),
          Positioned(
              top: h / 2.3,
              child: SizedBox(
                width: w,
                child: Center(
                  child: Text(
                    tr('onboarding.title'),
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: ColorsTheme.primaryWhite),
                  ),
                ),
              )),
          Positioned(
              top: h / 2.05,
              child: SizedBox(
                width: w,
                child: Center(
                  child: Text(
                    tr('onboarding.description'),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: ColorsTheme.primaryWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          Positioned(
              top: h / 1.3,
              left: w / 4,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/bottom_tapbar');
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorsTheme.lightSeaGreenColor.withOpacity(0.6),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  height: 50,
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr('onboarding.button'),
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: ColorsTheme.primaryWhite),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.skip_next,
                          size: 32, color: ColorsTheme.primaryWhite)
                    ],
                  ),
                ),
              )),
          Positioned(
            top: h / 1.2,
            left: w / 2.5,
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state is OnboardingLoadSuccess) {
                  return SizedBox(
                    width: w,
                    height: h * (0.025),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.all(6),
                              child: Container(
                                width: 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: i == curenindex
                                        ? ColorsTheme.blueColor
                                        : Colors.white),
                              ),
                            )),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

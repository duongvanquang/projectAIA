import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_dependencies.dart';
import 'blocs/configuration/configuration_bloc.dart';
import 'route_name/route_name.dart';
import 'theme/color_theme.dart';
import 'theme/movies_theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late StreamSubscription _subcrpiption;
  final GlobalKey<ScaffoldMessengerState> _snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  // final _userBloc = UserBloc(userServices: UserServices());

  // final _configurationBloc =
  //     ConfigurationBloc(configurationServices: ConfigurationServices());

  // final _onboardingBloc = OnboardingBloc(apiServices: ApiServices());

  // final _discoverBloc = DiscoverBloc(apiServices: ApiServices());

  // final _genresBloc = GenresBloc(genresType: ApiServices());

  // final _personBloc = PersonBloc(personData: ApiServices());

  // final _personIdBloc = PersonidBloc(personid: ApiServices());

  // final _detailTvBloc = DetailMovieBloc(services: ApiServices());

  // final _detailCommingSoonBloc = DetailBloc(services: ApiServices());

  // final _favoritiesBloc = FavoritiesBloc(apiFavorities: ApiFavorities());

  // final _searchBloc = SearchBloc(
  //     services: ApiServices(), configurationServices: ConfigurationServices());
  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet ? tr('app.connected') : tr('app.disconnected');
    final color = hasInternet ? ColorsTheme.greenColor : ColorsTheme.redColor;
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    _snackbarKey.currentState?.showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _subcrpiption =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }

  @override
  void dispose() {
    _subcrpiption.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: _snackbarKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: MoviesTheme.buildTheme(),
        routes: buildRoutes(),
        // initialRoute: initRouter(),
      );
}

String initRouter() => isLogin()
    ? isOnboarding()
        ? RouteName.bottomTapbar
        : RouteName.onboading
    : RouteName.login;
bool isLogin() => true;
bool isOnboarding() => true;

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
        initialRoute: initRouter(),
      );
}

String initRouter() => isLogin()
    ? isOnboarding()
        ? RouteName.bottomTapbar
        : RouteName.onboading
    : RouteName.login;
bool isLogin() => true;
bool isOnboarding() => true;

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/configuration/configuration_bloc.dart';
import 'blocs/detailmovie/detailmovie_bloc.dart';
import 'blocs/detailtv/detail_bloc.dart';
import 'blocs/discover/discover_bloc.dart';
import 'blocs/favorities/favorities_bloc.dart';
import 'blocs/genres/genres_bloc.dart';
import 'blocs/onboarding/onboarding_bloc.dart';
import 'blocs/person/person_bloc.dart';
import 'blocs/personid/personid_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'screens/bottom_appbar.dart';
import 'screens/detail_commingsoon.dart';
import 'screens/detail_genrestype_screen.dart';
import 'screens/detail_movie_screen.dart';
import 'screens/detail_personid.dart';
import 'screens/homescreen.dart';
import 'screens/image_photo_screen.dart';
import 'screens/loginscreen.dart';
import 'screens/onboarding.dart';
import 'screens/see_all_screen.dart';
import 'screens/signupscreen.dart';
import 'services/api_services.dart';
import 'services/configuration_services.dart';
import 'services/favorities_services.dart';
import 'services/user_services.dart';
import 'theme/movies_theme.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _userBloc = UserBloc(userServices: UserServices());
  final _configurationBloc =
      ConfigurationBloc(configurationServices: ConfigurationServices());
  final _onboardingBloc = OnboardingBloc(apiServices: ApiServices());
  final _discoverBloc = DiscoverBloc(apiServices: ApiServices());
  final _genresBloc = GenresBloc(genresType: ApiServices());
  final _personBloc = PersonBloc(personData: ApiServices());
  final _personIdBloc = PersonidBloc(personid: ApiServices());
  final _detailTvBloc = DetailMovieBloc(services: ApiServices());
  final _detailCommingSoonBloc = DetailBloc(services: ApiServices());
  final _favoritiesBloc = FavoritiesBloc(apiFavorities: ApiFavorities());
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _userBloc),
          BlocProvider.value(value: _configurationBloc),
          BlocProvider.value(value: _onboardingBloc),
          BlocProvider.value(value: _discoverBloc),
          BlocProvider.value(value: _genresBloc),
          BlocProvider.value(value: _personBloc),
          BlocProvider.value(value: _personIdBloc),
          BlocProvider.value(value: _detailTvBloc),
          BlocProvider.value(value: _detailCommingSoonBloc),
          BlocProvider.value(value: _favoritiesBloc)
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: MoviesTheme.buildTheme(),
          routes: {
            '/': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/home': (context) => const HomeScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/bottom_tapbar': (context) => const BottomTapBar(),
            '/genres_type': (context) => const DetailGenresTypeScreen(),
            '/detail_personid': (context) => const DetailPersonIdScreen(),
            '/detail_movie': (context) => const DetailMovieScreen(),
            '/detail_commingsoon': (context) => const DetailTVScreen(),
            '/image_photo': (context) => const ImagePhotoScreen(),
            '/see_all': (context) => const SeeAllScreen()
          },
        ),
      );
}

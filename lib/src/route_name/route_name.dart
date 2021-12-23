import 'package:flutter/material.dart';

import '../screens/bottom_navigator_screen.dart';
import '../screens/detail_commingsoon_screen.dart';
import '../screens/detail_genrestype_screen.dart';
import '../screens/detail_movie_screen.dart';
import '../screens/detail_person_id_screen.dart';
import '../screens/image_photo_screen.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/search_screen.dart';
import '../screens/see%20_all_discover_screen.dart';
import '../screens/see_all_commingsoon_screen.dart';
import '../screens/signup_screen.dart';

Map<String, WidgetBuilder> buildRoutes() => {
      RouteName.login: (context) => const LoginScreen(),
      RouteName.signup: (context) => const SignupScreen(),
      RouteName.onboading: (context) => const OnboardingScreen(),
      RouteName.bottomTapbar: (context) => const BottomTapBar(),
      RouteName.detailGenres: (context) => const DetailGenresTypeScreen(),
      RouteName.detailPerson: (context) => const DetailPersonIdScreen(),
      RouteName.detailMovie: (context) => const DetailMovieScreen(),
      RouteName.detailTv: (context) => const DetailTvScreen(),
      RouteName.imagePhoto: (context) => const ImagePhotoScreen(),
      RouteName.seeAllDiscoverData: (context) => const SeeAllTvScreen(),
      RouteName.seeAllCommingSoonData: (context) => const SeeAllMovieScreen(),
      RouteName.search: (context) => const SearchScreen(),
    };

mixin RouteName {
  static String login = '/';
  static String bottomTapbar = '/bottom_tapbar';
  static String onboading = '/onboading';
  static String signup = '/signup';
  static String detailGenres = '/genres_type';
  static String detailPerson = '/detail_personid';
  static String detailMovie = '/detail_movie';
  static String detailTv = '/detail_commingsoon';
  static String imagePhoto = '/image_photo';
  static String seeAllDiscoverData = '/see_all_discover';
  static String seeAllCommingSoonData = '/see_all_commingsoon';
  static String search = '/search';
}

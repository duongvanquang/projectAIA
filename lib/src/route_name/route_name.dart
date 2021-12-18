import 'package:flutter/material.dart';

import '../screens/bottom_appbar.dart';
import '../screens/detail_commingsoon_screen.dart';
import '../screens/detail_genrestype_screen.dart';
import '../screens/detail_movie_screen.dart';
import '../screens/detail_person_id_screen.dart';
import '../screens/image_photo_screen.dart';
import '../screens/loginscreen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/see_all_screen.dart';
import '../screens/signup_screen.dart';

Map<String, WidgetBuilder> buildRoutes() => {
      RouteName.login: (context) => const LoginScreen(),
      RouteName.signup: (context) => const SignupScreen(),
      RouteName.onboading: (context) => const OnboardingScreen(),
      RouteName.bottomTapbar: (context) => const BottomTapBar(),
      RouteName.detailGenres: (context) => const DetailGenresTypeScreen(),
      RouteName.detailPerson: (context) => const DetailPersonIdScreen(),
      RouteName.detailMovie: (context) => const DetailMovieScreen(),
      RouteName.detailTv: (context) => const DetailTVScreen(),
      RouteName.imagePhoto: (context) => const ImagePhotoScreen(),
      RouteName.seeAll: (context) => const SeeAllScreen()
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
  static String seeAll = '/see_all';
}

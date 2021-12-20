import 'package:flutter_simple_dependency_injection/injector.dart';

import '../services/api_services.dart';
import '../services/configuration_services.dart';
import '../services/favorities_services.dart';
import '../services/user_services.dart';
import 'configuration/configuration_bloc.dart';
import 'detail_movie/detailmovie_bloc.dart';
import 'detail_tv/detail_bloc.dart';
import 'discover/discover_bloc.dart';
import 'favorities/favorities_bloc.dart';
import 'genres/genres_bloc.dart';
import 'onboarding/onboarding_bloc.dart';
import 'person/person_bloc.dart';
import 'person_id/personid_bloc.dart';
import 'search/search_bloc.dart';
import 'user/user_bloc.dart';

mixin Dependencies {
  static Injector initialise(Injector injector) {
    injector.map<ConfigurationBloc>((injector) => ConfigurationBloc(
        configurationServices: injector.get<ConfigurationServices>()));
    injector.map<DetailMovieBloc>(
        (injector) => DetailMovieBloc(services: injector.get<ApiServices>()));
    injector.map<UserBloc>(
        (injector) => UserBloc(userServices: injector.get<UserServices>()));
    injector.map<DetailBloc>(
        (injector) => DetailBloc(services: injector.get<ApiServices>()));
    injector.map<DiscoverBloc>(
        (injector) => DiscoverBloc(apiServices: injector.get<ApiServices>()));
    injector.map<FavoritiesBloc>((injector) =>
        FavoritiesBloc(apiFavorities: injector.get<ApiFavorities>()));
    injector.map<GenresBloc>(
        (injector) => GenresBloc(genresType: injector.get<ApiServices>()));
    injector.map<OnboardingBloc>(
        (injector) => OnboardingBloc(apiServices: injector.get<ApiServices>()));
    injector.map<PersonBloc>(
        (injector) => PersonBloc(personData: injector.get<ApiServices>()));
    injector.map<PersonidBloc>(
        (injector) => PersonidBloc(personid: injector.get<ApiServices>()));
    injector.map<SearchBloc>((injector) => SearchBloc(
        configurationServices: injector.get<ConfigurationServices>(),
        services: injector.get<ApiServices>()));
    return injector;
  }
}

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import './favorities_event.dart';
import './favorities_state.dart';
import '../../services/favorities_services.dart';

class FavoritiesBloc extends Bloc<FavoritiesEvent, FavoritiesState> {
  final ApiFavorities? apiFavorities;
  FavoritiesBloc({required this.apiFavorities}) : super(FavoritiesInitial());
  bool favoritiesSuccess = false;
  @override
  Stream<FavoritiesState> mapEventToState(FavoritiesEvent event) async* {
    switch (event.runtimeType) {
      case FavoritiesStartted:
        final favoritiesData = event as FavoritiesStartted;
        try {
          yield FavoritiesLoadInProgress();
          await apiFavorities!.favorities(
              favoritiesData.userName,
              favoritiesData.fullName,
              favoritiesData.type,
              favoritiesData.moviesId,
              favoritiesData.moviesName,
              favoritiesData.imagePath,
              favoritiesData.dataTimeCreated);
          yield FavoritiesLoadInSuccess(favoritiesSuccess: !favoritiesSuccess);
        } on Exception {
          yield FavoritiesLoadInFailure(error: tr('error'));
        }
    }
  }
}

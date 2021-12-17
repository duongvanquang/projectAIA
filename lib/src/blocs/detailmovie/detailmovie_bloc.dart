import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../services/api_services.dart';
import 'detailmovie_event.dart';
import 'detailmovie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final ApiServices? services;
  DetailMovieBloc({required this.services}) : super(DetailMovieInitial());
  @override
  Stream<DetailMovieState> mapEventToState(DetailMovieEvent event) async* {
    switch (event.runtimeType) {
      case DetailStartted:
        final detailMovieId = event as DetailStartted;
        try {
          yield DetailMovieLoadInProgress();

          final detailMovieData =
              await services!.getDetailMovieData(detailMovieId.id);
          yield DetailMovieLoadInSuccess(
            detailMovieModel: detailMovieData,
          );
        } on Exception {
          yield DetailMovieLoadInFailure(error: tr('error Image'));
        }
    }
  }
}

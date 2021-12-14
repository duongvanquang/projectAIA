import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import './detailtv_event.dart';
import './detailtv_state.dart';
import '../../services/api_services.dart';

class DetailtvBloc extends Bloc<DetailtvEvent, DetailtvState> {
  final ApiServices? detailTVData;
  DetailtvBloc({required this.detailTVData}) : super(DetailtvInitial());
  @override
  Stream<DetailtvState> mapEventToState(DetailtvEvent event) async* {
    switch (event.runtimeType) {
      case DetailStartted:
        final detailTvId = event as DetailStartted;
        try {
          yield DetailTvLoadInProgress();
          final detailTvData =
              await detailTVData!.getDetailMovieData(detailTvId.id);
          yield DetailTvLoadInSuccess(detailTvModel: detailTvData);
        } on Exception {
          yield DetailTvLoadInFailure(error: tr('error Image'));
        }
    }
  }
}

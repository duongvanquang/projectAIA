import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import './detail_event.dart';
import './detail_state.dart';
import '../../services/api_services.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ApiServices? services;
  DetailBloc({required this.services}) : super(DetailInitial());
  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    switch (event.runtimeType) {
      case DetailCoomingSoonStartted:
        final commingsoonId = event as DetailCoomingSoonStartted;
        try {
          yield DetailCommingSoonLoadInProgress();
          final detailCommingSoon =
              await services!.getDetailTvData(commingsoonId.id);
          yield DetailCommingSoonLoadInSuccess(
            detailCommingSoon: detailCommingSoon,
          );
        } on Exception {
          yield DetailCommingSoonLoadInFailure(error: tr(''));
        }
    }
  }
}

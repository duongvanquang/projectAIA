import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../model/discover_model.dart';
import '../../model/movies_model.dart';
import '../../services/api_services.dart';
import 'discover_event.dart';
import 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final ApiServices? apiServices;
  DiscoverBloc({required this.apiServices}) : super(DiscoverInitial());
  @override
  Stream<DiscoverState> mapEventToState(DiscoverEvent event) async* {
    switch (event.runtimeType) {
      case DiscoverStartted:
        try {
          var _discoverData = <DiscoverModel>[];
          var _commingSoonData = <Movie>[];
          yield DiscoverLoadInProgress();
          await Future.wait([
            apiServices!
                .getDiscoverData()
                .then((value) => _discoverData = value),
            apiServices!
                .getCommingsoonData()
                .then((value) => _commingSoonData = value)
          ]);

          yield DiscoverLoadSuccess(
              discoverdata: _discoverData, commingsoon: _commingSoonData);
        } on Exception {
          yield DiscoverLoadFailure(error: tr(''));
        }
    }
  }
}

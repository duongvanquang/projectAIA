import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import './search_event.dart';
import './search_state.dart';
import '../../services/api_services.dart';
import '../../services/configuration_services.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiServices? services;
  final ConfigurationServices? configurationServices;
  SearchBloc({this.services, this.configurationServices})
      : super(SearchInitial());
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    switch (event.runtimeType) {
      case SearchStartted:
        final dataSearch = event as SearchStartted;
        try {
          yield SearchLoadInProgress();
          final searchMultil =
              await services!.getDataSearchMulti(1, dataSearch.textvalue);
          final dataCofiguration =
              await configurationServices!.getImageConfiguration();
          if (searchMultil.isNotEmpty) {
            yield SearchLoaInSuccess(
                configurationModel: dataCofiguration, searchData: searchMultil);
          } else {
            yield SearchLoadInFaiLure(error: tr('homeScreen.failureNoResults'));
          }
        } on Exception {
          yield SearchLoadInFaiLure(error: tr('error'));
        }
    }
  }
}

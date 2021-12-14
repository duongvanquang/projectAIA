import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import './configuration_event.dart';
import './configuration_state.dart';
import '../../services/configuration_services.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final ConfigurationServices? configurationServices;
  ConfigurationBloc({required this.configurationServices})
      : super(ConfigurationInitial());
  @override
  Stream<ConfigurationState> mapEventToState(ConfigurationEvent event) async* {
    switch (event.runtimeType) {
      case ConfigurationStarted:
        try {
          final configuration =
              await configurationServices!.getImageConfiguration();
          yield ConfigurationStartSuccess(configurationModel: configuration);
        } on Exception {
          yield ConfigurationStartFailure(
              error: tr('homescreen.configurationfailure'));
        }
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import './person_event.dart';
import './person_state.dart';
import '../../services/api_services.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final ApiServices? personData;
  PersonBloc({required this.personData}) : super(PersonInitial());
  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    switch (event.runtimeType) {
      case PersonStartted:
        try {
          yield PersonLoadInProgress();
          final getPersonData = await personData!.getPersonData();
          yield PersonLoadInSuccess(personModel: getPersonData);
        } on Exception {
          yield PersonLoadInFailure(error: tr(''));
        }
    }
  }
}

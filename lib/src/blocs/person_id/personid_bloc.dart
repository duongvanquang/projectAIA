import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import './personid_event.dart';
import './personid_state.dart';
import '../../services/api_services.dart';

class PersonidBloc extends Bloc<PersonidEvent, PersonidState> {
  final ApiServices? personid;
  PersonidBloc({required this.personid}) : super(PersonidInitial());

  @override
  Stream<PersonidState> mapEventToState(PersonidEvent event) async* {
    switch (event.runtimeType) {
      case PersonIdStartted:
        final idPerson = event as PersonIdStartted;
        try {
          yield PersonIdLoadInProgress();
          final personIdData = await personid!.getPersonIdData(idPerson.id!);
          yield PersonIdLoadInSuccess(personId: personIdData);
        } on Exception {
          yield PersonIdLoadInFailure(error: tr('error'));
        }
    }
  }
}

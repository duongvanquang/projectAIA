import 'package:equatable/equatable.dart';
import '../../model/person_model.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

class PersonInitial extends PersonState {}

class PersonLoadInProgress extends PersonState {}

class PersonLoadInSuccess extends PersonState {
  final List<PersonModel> personModel;
  const PersonLoadInSuccess({required this.personModel});
  @override
  List<Object> get props => [personModel];
}

class PersonLoadInFailure extends PersonState {
  final String? error;
  const PersonLoadInFailure({this.error});
  @override
  List<Object> get props => [error!];
}

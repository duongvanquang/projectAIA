import 'package:equatable/equatable.dart';
import '../../model/person_model.dart';

abstract class PersonidState extends Equatable {
  const PersonidState();

  @override
  List<Object> get props => [];
}

class PersonidInitial extends PersonidState {}

class PersonIdLoadInProgress extends PersonidState {}

class PersonIdLoadInSuccess extends PersonidState {
  final PersonModel personId;
  const PersonIdLoadInSuccess({required this.personId});
  @override
  List<Object> get props => [personId];
}

class PersonIdLoadInFailure extends PersonidState {
  final String? error;
  const PersonIdLoadInFailure({required this.error});
  @override
  List<Object> get props => [error!];
}

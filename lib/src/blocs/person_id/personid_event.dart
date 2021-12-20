import 'package:equatable/equatable.dart';

abstract class PersonidEvent extends Equatable {
  const PersonidEvent();

  @override
  List<Object> get props => [];
}

class PersonIdStartted extends PersonidEvent {
  final int? id;
  const PersonIdStartted({required this.id});
  @override
  List<Object> get props => [id!];
}

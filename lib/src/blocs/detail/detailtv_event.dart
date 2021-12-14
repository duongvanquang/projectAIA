import 'package:equatable/equatable.dart';

abstract class DetailtvEvent extends Equatable {
  const DetailtvEvent();

  @override
  List<Object> get props => [];
}

class DetailStartted extends DetailtvEvent {
  final int id;
  const DetailStartted({required this.id});
  @override
  List<Object> get props => [id];
}

import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailCoomingSoonStartted extends DetailEvent {
  final int id;
  const DetailCoomingSoonStartted({required this.id});
  @override
  List<Object> get props => [id];
}

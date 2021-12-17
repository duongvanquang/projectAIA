import 'package:equatable/equatable.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class DetailStartted extends DetailMovieEvent {
  final int id;
  const DetailStartted({required this.id});
  @override
  List<Object> get props => [id];
}

import 'package:equatable/equatable.dart';
import '../../model/movies_model.dart';

abstract class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object> get props => [];
}

class GenresInitial extends GenresState {}

class GenresLoadInProgress extends GenresState {}

class GenresLoadInSuccess extends GenresState {
  final List<Movie> movies;
  const GenresLoadInSuccess({required this.movies});
  @override
  List<Object> get props => [movies];
}

class GenresLoadInFailure extends GenresState {
  final String? error;
  const GenresLoadInFailure({required this.error});
  @override
  List<Object> get props => [error!];
}

import 'package:equatable/equatable.dart';

abstract class FavoritiesState extends Equatable {
  const FavoritiesState();

  @override
  List<Object> get props => [];
}

class FavoritiesInitial extends FavoritiesState {}

class FavoritiesLoadInProgress extends FavoritiesState {}

class FavoritiesLoadInSuccess extends FavoritiesState {
  final bool favoritiesSuccess;
  const FavoritiesLoadInSuccess({required this.favoritiesSuccess});
  @override
  List<Object> get props => [favoritiesSuccess];
}

class FavoritiesLoadInFailure extends FavoritiesState {
  final String? error;
  const FavoritiesLoadInFailure({required this.error});
  @override
  List<Object> get props => [error!];
}

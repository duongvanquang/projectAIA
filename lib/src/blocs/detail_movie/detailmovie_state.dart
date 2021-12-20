import 'package:equatable/equatable.dart';

import '../../model/detail_tv_model.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMovieInitial extends DetailMovieState {}

class DetailMovieLoadInProgress extends DetailMovieState {}

class DetailMovieLoadInSuccess extends DetailMovieState {
  final DetailTvModel detailMovieModel;

  const DetailMovieLoadInSuccess({required this.detailMovieModel});
  @override
  List<Object> get props => [detailMovieModel];
}

class DetailMovieLoadInFailure extends DetailMovieState {
  final String? error;
  const DetailMovieLoadInFailure({required this.error});
  @override
  List<Object> get props => [error!];
}

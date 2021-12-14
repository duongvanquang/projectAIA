import 'package:equatable/equatable.dart';
import '../../model/detail_tv_model.dart';

abstract class DetailtvState extends Equatable {
  const DetailtvState();

  @override
  List<Object> get props => [];
}

class DetailtvInitial extends DetailtvState {}

class DetailTvLoadInProgress extends DetailtvState {}

class DetailTvLoadInSuccess extends DetailtvState {
  final DetailTvModel detailTvModel;
  const DetailTvLoadInSuccess({required this.detailTvModel});
  @override
  List<Object> get props => [detailTvModel];
}

class DetailTvLoadInFailure extends DetailtvState {
  final String? error;
  const DetailTvLoadInFailure({required this.error});
  @override
  List<Object> get props => [error!];
}

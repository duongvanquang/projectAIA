import 'package:equatable/equatable.dart';
import 'package:moviesaia/src/model/review_model.dart';
import '../../model/detail_tv_model.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailCommingSoonLoadInProgress extends DetailState {}

class DetailCommingSoonLoadInSuccess extends DetailState {
  final DetailTvModel detailCommingSoon;

  const DetailCommingSoonLoadInSuccess({required this.detailCommingSoon});
  @override
  List<Object> get props => [detailCommingSoon];
}

class DetailCommingSoonLoadInFailure extends DetailState {
  final String? error;
  const DetailCommingSoonLoadInFailure({required this.error});
  @override
  List<Object> get props => [error!];
}

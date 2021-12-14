import 'package:equatable/equatable.dart';

import '../../model/discover_model.dart';
import '../../model/movies_model.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

class DiscoverInitial extends DiscoverState {}

class DiscoverLoadInProgress extends DiscoverState {}

class DiscoverLoadSuccess extends DiscoverState {
  final List<DiscoverModel> discoverdata;
  final List<Movie> commingsoon;
  const DiscoverLoadSuccess(
      {required this.discoverdata, required this.commingsoon});
  @override
  List<Object> get props => [discoverdata, commingsoon];
}

class DiscoverLoadFailure extends DiscoverState {
  final String? error;
  const DiscoverLoadFailure({this.error});
  @override
  List<Object> get props => [error!];
}

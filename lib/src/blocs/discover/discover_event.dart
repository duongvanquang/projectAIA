import 'package:equatable/equatable.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

class DiscoverStartted extends DiscoverEvent {}

class LoadMorePageDatated extends DiscoverEvent {
  final int nextpage;

  const LoadMorePageDatated({
    required this.nextpage,
  });
  @override
  List<Object> get props => [nextpage];
}

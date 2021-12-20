import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStartted extends SearchEvent {
  final String textvalue;
  const SearchStartted({required this.textvalue});
  @override
  List<Object> get props => [textvalue];
}

class SearchResultsChanged extends SearchEvent {
  const SearchResultsChanged();
}

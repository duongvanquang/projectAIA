import 'package:equatable/equatable.dart';

import '../../model/movies_configuration.dart';
import '../../model/search_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadInProgress extends SearchState {}

class SearchLoaInSuccess extends SearchState {
  final List<SearchModel> searchData;
  final ConfigurationModel configurationModel;
  const SearchLoaInSuccess(
      {required this.searchData, required this.configurationModel});
  @override
  List<Object> get props => [searchData, configurationModel];
}

class SearchLoadInFaiLure extends SearchState {
  final String? error;
  const SearchLoadInFaiLure({this.error});
  @override
  List<Object> get props => [error!];
}

class SearchBoxEmpty extends SearchState {}

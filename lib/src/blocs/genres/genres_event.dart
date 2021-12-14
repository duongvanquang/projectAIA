import 'package:equatable/equatable.dart';

abstract class GenresEvent extends Equatable {
  const GenresEvent();

  @override
  List<Object> get props => [];
}

class GenresSectionStartted extends GenresEvent {
  final String genreType;

  const GenresSectionStartted({required this.genreType});
  @override
  List<Object> get props => [genreType];
}

class LoadMorePageDataMoviested extends GenresEvent {
  final int nextpage;
  final String genreType;
  const LoadMorePageDataMoviested(
      {required this.nextpage, required this.genreType});
  @override
  List<Object> get props => [nextpage, genreType];
}

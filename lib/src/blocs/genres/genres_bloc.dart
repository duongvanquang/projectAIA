import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import './genres_event.dart';
import './genres_state.dart';
import '../../services/api_services.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final ApiServices? genresType;
  GenresBloc({required this.genresType}) : super(GenresInitial());
  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {
    switch (event.runtimeType) {
      case GenresSectionStartted:
        final genresTypeRequested = event as GenresSectionStartted;
        try {
          yield GenresLoadInProgress();
          final sectionData =
              await genresType!.getMoviesData(genresTypeRequested.genreType, 1);
          yield GenresLoadInSuccess(movies: sectionData);
        } on Exception {
          yield GenresLoadInFailure(error: tr(''));
        }
        break;
      case LoadMorePageDataMoviested:
        final loadmore = event as LoadMorePageDataMoviested;
        try {
          final loadmoreMovies = await genresType!
              .getMoviesData(loadmore.genreType, loadmore.nextpage);
          yield GenresLoadInSuccess(movies: loadmoreMovies);
        } on Exception {
          yield GenresLoadInFailure(error: tr(''));
        }
    }
  }
}

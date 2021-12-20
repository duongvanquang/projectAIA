import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../theme/color_theme.dart';
import '../widgtes/artists_tabbar_search.dart';
import '../widgtes/custom_tabar_search.dart';
import '../widgtes/genres_tabbar_search.dart';
import '../widgtes/movie_tabbar_search.dart';
import '../widgtes/series_tabbar_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  Timer? setTimer;
  void clearTextInput() {
    _controller.clear();
  }

  @override
  void initState() {
    context.read<SearchBloc>().add(const SearchResultsChanged());
    super.initState();
  }

  void _textFieldOnChangedCallback(String text) {
    final _searchBloc = context.read<SearchBloc>();

    if (text.isNotEmpty) {
      _searchBloc.add(SearchStartted(textvalue: text));
    } else {
      clearTextInput();
      _searchBloc.add(const SearchResultsChanged());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            height: 40,
            width: 345,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: ColorsTheme.secondaryGrey.withOpacity(0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Search',
                    border: InputBorder.none),
                onChanged: _textFieldOnChangedCallback,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 26,
              color: ColorsTheme.blueColor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: ColorsTheme.blueColor),
                ),
              ),
            )
          ],
        ),
        body: const TabbarSearch(
          firtTabbar: 'Movies',
          secondTabbar: 'Series',
          thirdTabbar: 'Genres',
          lastTabbar: 'Artists',
          firtTabbarSearch: MovieTabbarSearch(),
          secondTabbarSearch: SeriesTabbarSearch(),
          thirdTabbarSearch: GenresTabbarSearch(),
          lastTabbarSearch: ArtistsTabbarSearch(),
        ),
      );
}

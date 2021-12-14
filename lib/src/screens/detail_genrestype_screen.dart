import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/genres/genres_bloc.dart';
import '../blocs/genres/genres_event.dart';
import '../blocs/genres/genres_state.dart';
import '../theme/color_theme.dart';
import '../widgtes/item_genres.dart';

class DetailGenresTypeScreen extends StatefulWidget {
  final String? title;
  final String? image;
  final String? genreType;
  const DetailGenresTypeScreen(
      {this.genreType, this.title, this.image, Key? key})
      : super(key: key);

  @override
  State<DetailGenresTypeScreen> createState() => _DetailGenresTypeScreenState();
}

class _DetailGenresTypeScreenState extends State<DetailGenresTypeScreen> {
  late ScrollController _controllerpage;
  int _nextpage = 1;
  void _loadmore() {
    if (_controllerpage.position.extentAfter == 0) {
      _nextpage++;
      BlocProvider.of<GenresBloc>(context).add(
        LoadMorePageDataMoviested(
            nextpage: _nextpage, genreType: widget.genreType!),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerpage = ScrollController()..addListener(_loadmore);
  }

  @override
  void dispose() {
    _controllerpage.removeListener(_loadmore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 200),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.navigate_before,
                    size: 32, color: ColorsTheme.primaryBlack),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.title!,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: ColorsTheme.primaryBlack),
              ),
              const Spacer(),
              Image(
                  width: 50,
                  height: 50,
                  image: AssetImage('assets/images/${widget.image!}.png'))
            ],
          ),
        ),
      ),
      body: BlocBuilder<GenresBloc, GenresState>(
        builder: (context, state) {
          if (state is GenresLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GenresLoadInSuccess) {
            return GridView.builder(
                controller: _controllerpage,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.5,
                    mainAxisSpacing: 0.6),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final item = state.movies[index];
                  return ItemGenres(itemMovie: item);
                });
          }
          return const SizedBox.shrink();
        },
      ));
}

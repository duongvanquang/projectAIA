import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

class TabbarSearch extends StatefulWidget {
  final String firtTabbar;
  final String secondTabbar;
  final String thirdTabbar;
  final String lastTabbar;
  final Widget firtTabbarSearch;
  final Widget secondTabbarSearch;
  final Widget thirdTabbarSearch;
  final Widget lastTabbarSearch;

  const TabbarSearch(
      {required this.firtTabbar,
      required this.secondTabbar,
      required this.thirdTabbar,
      required this.lastTabbar,
      required this.firtTabbarSearch,
      required this.secondTabbarSearch,
      required this.lastTabbarSearch,
      required this.thirdTabbarSearch,
      Key? key})
      : super(key: key);

  @override
  State<TabbarSearch> createState() => _TabbarSearchState();
}

class _TabbarSearchState extends State<TabbarSearch>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: TabBar(
              indicatorColor: ColorsTheme.blueColor,
              indicatorWeight: 4,
              controller: _controller,
              tabs: <Widget>[
                Tab(
                  child: Text(widget.firtTabbar,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: _controller.index == 0
                              ? ColorsTheme.blueColor
                              : ColorsTheme.secondaryGrey)),
                ),
                Tab(
                  child: Text(widget.secondTabbar,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: _controller.index == 1
                              ? ColorsTheme.blueColor
                              : ColorsTheme.secondaryGrey)),
                ),
                Tab(
                  child: Text(widget.thirdTabbar,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: _controller.index == 2
                              ? ColorsTheme.blueColor
                              : ColorsTheme.secondaryGrey)),
                ),
                Tab(
                  child: Text(widget.lastTabbar,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: _controller.index == 3
                              ? ColorsTheme.blueColor
                              : ColorsTheme.secondaryGrey)),
                ),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                widget.firtTabbarSearch,
                widget.secondTabbarSearch,
                widget.thirdTabbarSearch,
                widget.lastTabbarSearch,
              ],
            ),
          ),
        ],
      );
}

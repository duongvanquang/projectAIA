import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

class TabbarView extends StatefulWidget {
  final String firtTabbar;
  final String secondTabbar;
  final String lastTabbar;
  final Widget firtTabbarView;
  final Widget secondTabbarView;
  final Widget lastTabbarView;
  const TabbarView(
      {required this.firtTabbar,
      required this.secondTabbar,
      required this.lastTabbar,
      required this.firtTabbarView,
      required this.secondTabbarView,
      required this.lastTabbarView,
      Key? key})
      : super(key: key);

  @override
  State<TabbarView> createState() => _TabbarViewState();
}

class _TabbarViewState extends State<TabbarView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
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
                  child: Text(widget.lastTabbar,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: _controller.index == 2
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
                widget.firtTabbarView,
                widget.secondTabbarView,
                widget.lastTabbarView
              ],
            ),
          ),
        ],
      );
}

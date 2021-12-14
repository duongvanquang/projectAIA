import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesaia/src/theme/color_theme.dart';

import 'artists_screen.dart';
import 'discover_screen.dart';
import 'genres_screen.dart';

class BottomTapBar extends StatefulWidget {
  const BottomTapBar({Key? key}) : super(key: key);

  @override
  _BottomTapBarState createState() => _BottomTapBarState();
}

class _BottomTapBarState extends State<BottomTapBar> {
  int _selectedIndex = 0;
  static final List<Widget> _WidgetOption = [
    const DiscoverScreen(),
    const GenresScreen(),
    const ArtistsScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(child: _WidgetOption.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image(
                  width: 32,
                  height: 32,
                  color: _selectedIndex == 0
                      ? ColorsTheme.blueColor
                      : ColorsTheme.secondaryGrey,
                  image: const AssetImage('assets/images/Discover.png')),
              label: 'Discover'),
          BottomNavigationBarItem(
              icon: Image(
                  width: 32,
                  height: 32,
                  color: _selectedIndex == 1
                      ? ColorsTheme.blueColor
                      : ColorsTheme.secondaryGrey,
                  image: const AssetImage('assets/images/Genres.png')),
              label: 'Genres'),
          BottomNavigationBarItem(
              icon: Image(
                  width: 32,
                  height: 32,
                  color: _selectedIndex == 2
                      ? ColorsTheme.blueColor
                      : ColorsTheme.secondaryGrey,
                  image: const AssetImage('assets/images/Artists.png')),
              label: 'Artists')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ));
}

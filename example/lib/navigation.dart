import 'package:clean_bottom_navigation_bar/clean_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'blank.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Blank(),
    Blank(),
    Blank(),
    Blank(),
    Blank(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CleanNavigationBar(
        showFab: true,
        barHeight: 60,
        fabHeight: -30,
        currentIndex: _currentIndex,
        activeColor: Theme.of(context).primaryColor,
        tabColor: Theme.of(context).cardColor,
        indicatorColor: Theme.of(context).indicatorColor,
        titleStyle: Theme.of(context)
            .textTheme
            .caption
            .merge(TextStyle(color: Theme.of(context).cardColor)),
        onTap: onTabTapped,
        items: [
          CleanNavigationBarItem(title: Text('Home'), icon: Icons.home),
          CleanNavigationBarItem(title: Text('Search'), icon: Icons.search),
          CleanNavigationBarItem(title: Text('Bag'), icon: Icons.card_travel),
          CleanNavigationBarItem(
              title: Text('Orders'), icon: Icons.shopping_cart),
          CleanNavigationBarItem(
              title: Text('Settings'), icon: Icons.person_outline),
        ],
      ),
      body: _children[_currentIndex],
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

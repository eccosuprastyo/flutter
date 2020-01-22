import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'player_widget.dart';
import 'browse_widget.dart';
import 'search_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Apple Music',
        home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('Search'))
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (context) => BrowseWidget(),
                );
              case 1:
                return CupertinoTabView(
                  builder: (context) => SearchWidget(),
                );
              default:
                break;
            }
          },
        ));
  }
}

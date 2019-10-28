import 'package:flutter/material.dart';
import 'package:login/screen/login_screen.dart';

void main() => runApp(new MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sqflite App',
      theme: new ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}
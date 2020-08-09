import 'package:flutter/material.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/routes.dart';

class App extends StatelessWidget {
  static final routes = {
    Routes.home: (context) => ListScreen(),
    Routes.newPost: (context) => Placeholder(),
  };


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListScreen(),
    );
  }
}

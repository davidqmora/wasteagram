import 'package:flutter/material.dart';
import 'package:wasteagram/routes.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/screens/post_entry_screen.dart';
import 'package:wasteagram/services/analytics.dart';

class App extends StatelessWidget {
  static final routes = {
    Routes.home: (context) => ListScreen(),
    Routes.newPost: (context) => PostEntryScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
//        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      navigatorObservers: [
        Analytics().getNavigatorObserver(),
      ],
//      showSemanticsDebugger: true,
    );
  }
}

import 'package:flutter/material.dart';


class Chrome extends StatelessWidget {
  final Widget body;
  final Widget actionButton;
  final String title;

  Chrome({this.title = "Wasteagram", @required this.body, this.actionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: journalAppBar(this.title),
      body: this.body,
      floatingActionButton: this.actionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  AppBar journalAppBar(title) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: [
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            );
          },
        )
      ],
    );
  }

}


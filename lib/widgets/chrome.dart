import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chrome extends StatelessWidget {
  final Widget body;
  final Widget actionButton;
  final String title;
  final String semanticTitle;

  Chrome(
      {this.title = "Wasteagram",
      this.semanticTitle,
      @required this.body,
      this.actionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: journalAppBar(this.title),
      body: this.body,
      floatingActionButton: this.actionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
    );
  }

  AppBar journalAppBar(title) {
    return AppBar(
      centerTitle: true,
      title: screenTitle(title, semanticTitle),
    );
  }

  Widget screenTitle(title, semanticTitle) {
    if (semanticTitle == null) {
      return Semantics(
        child: Text(title),
      );
    } else {
      return Semantics(
        label: semanticTitle,
        child: ExcludeSemantics(
          child: Text(title),
        ),
      );
    }
  }
}

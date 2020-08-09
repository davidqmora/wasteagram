import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/chrome.dart';
import 'package:wasteagram/widgets/post_view.dart';

class PostViewScreen extends StatelessWidget {
  final dynamic _post;

  PostViewScreen(this._post);

  @override
  Widget build(BuildContext context) {
    return Chrome(
      body: PostView(_post),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/widgets/chrome.dart';
import 'package:wasteagram/widgets/post_view/post_view.dart';

class PostViewScreen extends StatelessWidget {
  final Post _post;

  PostViewScreen(this._post);

  @override
  Widget build(BuildContext context) {
    return Chrome(
      body: PostView(_post),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/widgets/post_list/post_tile.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;

  const PostsList({Key key, @required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      value: 'List of wasted item posts.',
      label: 'There are ${posts.length} posts.',
      child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            var post = posts[index];
            return PostTile(
              post: post,
              index: index,
            );
          }),
    );
  }
}

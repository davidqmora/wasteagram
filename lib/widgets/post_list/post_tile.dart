import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/screens/post_view_screen.dart';

import 'item_count.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final int index;

  const PostTile({Key key, @required this.post, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        onTapHint: "get more details",
        child: ListTile(
            key: ValueKey('post_$index'),
            title: postTitle(post),
            trailing: ItemCount(count: post.count),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostViewScreen(post),
              ));
            }),
      ),
    );
  }

  Widget postTitle(Post post) => Semantics(
        label: "Date",
        child: Text(
          DateFormat('EEEE, MMMM d, yyyy').format(post.date),
          key: ValueKey('date'),
        ),
      );
}

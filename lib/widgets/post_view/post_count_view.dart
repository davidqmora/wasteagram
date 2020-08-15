import 'package:flutter/material.dart';

class PostCountView extends StatelessWidget {
  final int itemCount;

  const PostCountView({
    Key key,
    @required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postfix = 'item';
    if (itemCount > 1) {
      postfix += 's';
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Semantics(
        hint: "wasted",
        child: Text(
          "${itemCount.toString()} $postfix",
          style: Theme.of(context).textTheme.headline6,
          key: ValueKey('item_count'),
        ),
      ),
    );
  }
}

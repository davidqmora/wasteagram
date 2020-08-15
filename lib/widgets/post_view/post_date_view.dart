import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDateView extends StatelessWidget {
  final DateTime date;

  const PostDateView({Key key, @required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 4, right: 4),
      alignment: Alignment.center,
      child: Semantics(
        label: 'Post date',
        child: Text(
          DateFormat('E, MMM d, yyyy').format(date),
          style: Theme.of(context).textTheme.headline4,
          key: ValueKey('date'),
        ),
      ),
    );
  }
}

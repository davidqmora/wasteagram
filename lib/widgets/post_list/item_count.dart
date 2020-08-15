import 'package:flutter/material.dart';

class ItemCount extends StatelessWidget {
  final int count;

  const ItemCount({Key key, @required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).accentColor.withOpacity(0.5),
      ),
      child: Semantics(
          label: 'Wasted Items',
          child: Text(
            '$count',
            key: ValueKey('item_count'),
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      alignment: Alignment.center,
    );
  }
}

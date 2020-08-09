import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PostView extends StatelessWidget {
  final dynamic _post;

  PostView(this._post);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title(context),
        body(context),
        photo(context),
      ],
    );
  }

  Widget title(context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, left: 4, right: 4),
      child: Text(
        DateFormat.yMMMd().format(_post["date"].toDate()),
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget body(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        _post['count'].toString(),
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget photo(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Placeholder(),
    );
  }
}

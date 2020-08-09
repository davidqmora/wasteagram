import 'package:flutter/cupertino.dart';
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
        date(context),
        photo(context),
        count(context),
        location(context),
      ],
    );
  }

  Widget date(context) {
    return Container(
      padding: EdgeInsets.only(top: 4, left: 4, right: 4),
      alignment: Alignment.center,
      child: Text(
        DateFormat.yMMMd().format(_post["date"].toDate()),
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget photo(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(20),
      child: Placeholder(),
    );
  }

  Widget count(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        "${_post['count'].toString()} items",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget location(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        "location(lon, lat)",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

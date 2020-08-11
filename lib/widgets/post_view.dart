import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/post.dart';

class PostView extends StatelessWidget {
  final Post _post;

  PostView(this._post);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          date(context),
          photo(context, constraints),
          count(context),
          location(context),
        ],
      );
    });
  }

  Widget date(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, left: 4, right: 4),
      alignment: Alignment.center,
      child: Text(
        DateFormat.yMMMd().format(_post.date),
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget photo(BuildContext context, BoxConstraints constraints) {
    var imageHeight = constraints.maxHeight / 3 * 2;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10),
      height: imageHeight,
      child: Image.network(
        _post.imageUrl,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget count(BuildContext context) {
    var postfix = 'item';
    if (_post.count > 1) {
      postfix += 's';
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        "${_post.count.toString()} $postfix",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget location(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        _post.location,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

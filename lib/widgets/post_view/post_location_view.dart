import 'package:flutter/material.dart';

class PostLocationView extends StatelessWidget {
  final double latitude;
  final double longitude;

  const PostLocationView(
      {Key key, @required this.latitude, @required this.longitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        'Location: Longitude=${longitude.toStringAsFixed(2)}, Latitude=${latitude.toStringAsFixed(2)}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/widgets/post_view/post_count_view.dart';
import 'package:wasteagram/widgets/post_view/post_date_view.dart';
import 'package:wasteagram/widgets/post_view/post_image_view.dart';
import 'package:wasteagram/widgets/post_view/post_location_view.dart';

class PostView extends StatelessWidget {
  final Post _post;

  PostView(this._post);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostDateView(date: _post.date),
          photo(context, constraints),
          PostCountView(itemCount: _post.count),
          PostLocationView(
            latitude: _post.latitude,
            longitude: _post.longitude,
          ),
        ],
      );
    });
  }

  Widget photo(BuildContext context, BoxConstraints constraints) {
    var imageHeight = constraints.maxHeight / 3 * 2;
    return PostImageView(imageUrl: _post.imageUrl, imageHeight: imageHeight);
  }
}

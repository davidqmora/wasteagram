import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPostImage extends StatelessWidget {
  final PickedFile image;
  final double imageHeight;

  const NewPostImage({
    Key key,
    @required this.imageHeight,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Image showing the wasted items.',
      child: Container(
        height: imageHeight,
        width: double.infinity,
        child: ExcludeSemantics(
          child: Image.file(
            File(image.path),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

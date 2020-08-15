import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wasteagram/widgets/wait_spinner.dart';

// Nice spinner+fade-in from
// https://flutter.dev/docs/cookbook/images/fading-in-images
class PostImageView extends StatelessWidget {
  final double imageHeight;
  final String imageUrl;

  const PostImageView({
    Key key,
    @required this.imageHeight,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
        label: 'Image showing the wasted items.',
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 20),
          height: imageHeight,
          child: ExcludeSemantics(
            child: Stack(
              children: [
                Center(child: WaitSpinner()),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

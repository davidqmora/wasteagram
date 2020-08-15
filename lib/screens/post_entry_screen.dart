import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/services/PostDAO.dart';
import 'package:wasteagram/services/analytics.dart';
import 'package:wasteagram/widgets/chrome.dart';
import 'package:wasteagram/widgets/post_entry/new_post_image.dart';
import 'package:wasteagram/widgets/post_entry/new_post_item_count.dart';
import 'package:wasteagram/widgets/post_entry/new_post_save_button.dart';

class PostEntryScreen extends StatefulWidget {
  @override
  _PostEntryScreenState createState() => _PostEntryScreenState();
}

class _PostEntryScreenState extends State<PostEntryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PickedFile _image;
  LocationData _location;
  Post _post = Post();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    _image = ModalRoute.of(context).settings.arguments;
    return Chrome(
      body: Form(
        key: _formKey,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              itemsImage(constraints),
              NewPostItemCount(
                  onSaved: (String value) => _post.count = int.parse(value)),
              Spacer(),
              NewPostSaveButton(
                onPressed: savePost,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget itemsImage(BoxConstraints constraints) {
    var imageHeight = constraints.maxHeight / 3;
    return NewPostImage(image: _image, imageHeight: imageHeight);
  }

  void savePost(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _post.date = DateTime.now();
      _post.longitude = _location?.longitude;
      _post.latitude = _location?.latitude;
      _post.imageUrl = _image.path;
      PostDAO().savePost(_post);
      Analytics().saveEvent('New post', _post.toMap());
      Navigator.of(context).pop();
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please enter a value of 1 or more for wasted items.',
          textAlign: TextAlign.center,
        ),
      ));
    }
  }

  void getLocation() async {
    var locationService = Location();
    var isEnabled = await locationService.serviceEnabled();
    var permissionStatus = await locationService.hasPermission();

    if (isEnabled && permissionStatus == PermissionStatus.granted) {
      _location = await locationService.getLocation();
    }

    setState(() {});
  }
}

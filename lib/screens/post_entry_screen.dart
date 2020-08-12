import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/services/PostDAO.dart';
import 'package:wasteagram/widgets/chrome.dart';

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
              itemCountPrompt(context),
              Spacer(),
              sendButton(context),
            ],
          );
        }),
      ),
    );
  }

  Widget itemsImage(BoxConstraints constraints) {
    var imageHeight = constraints.maxHeight / 3;
    return Semantics(
      label: 'Image showing the wasted items.',
      child: Container(
        height: imageHeight,
        width: double.infinity,
        child: ExcludeSemantics(
          child: Image.file(
            File(_image.path),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget itemCountPrompt(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Semantics(
        focused: true,
        focusable: true,
        label: "Wasted Items edit box.",
        value: "",
        hint: "Enter the number of wasted items. Must be higher than zero.",
        child: ExcludeSemantics(
          child: TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Number of Wasted items",
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
            autofocus: true,
            onSaved: (String value) => _post.count = int.parse(value),
            validator: (String value) {
              int count = int.tryParse(value);
              if (count == null || count <= 0) {
                return "Wasted items must be a number higher than zero.";
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget sendButton(context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Semantics(
        button: true,
        enabled: true,
        label: "Save post",
        onTapHint: "save new post",
        onTap: () {
          savePost(context);
        },
        child: ExcludeSemantics(
          child: RaisedButton(
            child: Icon(
              Icons.cloud_upload,
              size: 100,
              color: Theme.of(context).canvasColor,
            ),
            onPressed: () {
              savePost(context);
            },
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  void savePost(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _post.date = DateTime.now();
      _post.longitude = _location.longitude;
      _post.latitude = _location.latitude;
      _post.imageUrl = _image.path;
      PostDAO().savePost(_post);
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
    _location = await locationService.getLocation();
    setState(() {});
  }
}

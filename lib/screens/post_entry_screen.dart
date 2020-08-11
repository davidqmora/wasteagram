import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  var _post = Post();

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
              itemsImage(),
              itemCountPrompt(context),
              Spacer(),
              sendButton(context),
            ],
          );
        }),
      ),
    );
  }

  Widget itemsImage() {
    return Container(
      height: 300,
      width: double.infinity,
      child: Image.file(
        File(_image.path),
        fit: BoxFit.fill,
      ),
    );
  }

  Container itemCountPrompt(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.symmetric(horizontal: 10),
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
          int count = int.parse(value);
          if (count <= 0) {
            return "A number greater than zero must be provided.";
          } else {
            return null;
          }
        },
      ),
    );
  }

  sendButton(context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: RaisedButton(
        child: Icon(
          Icons.cloud_upload,
          size: 100,
          color: Theme.of(context).canvasColor,
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          savePost(context);
        },
      ),
    );
  }

  void savePost(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _post.date = DateTime.now();
      _post.location = '(long, lat)';
      _post.imageUrl = _image.path;
      PostDAO().savePost(_post);
      Navigator.of(context).pop();
    }
  }
}

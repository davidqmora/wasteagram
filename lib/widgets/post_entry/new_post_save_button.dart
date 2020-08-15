import 'package:flutter/material.dart';

class NewPostSaveButton extends StatelessWidget {
  final Function(BuildContext context) onPressed;

  const NewPostSaveButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Semantics(
        button: true,
        enabled: true,
        label: "Save post",
        onTapHint: "save new post",
        onTap: () {
//          savePost(context);
          onPressed(context);
        },
        child: ExcludeSemantics(
          child: RaisedButton(
            child: Icon(
              Icons.cloud_upload,
              size: 100,
              color: Theme.of(context).canvasColor,
            ),
            onPressed: () {
//              savePost(context);
              onPressed(context);
            },
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

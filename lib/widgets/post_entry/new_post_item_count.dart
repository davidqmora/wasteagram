import 'package:flutter/material.dart';

class NewPostItemCount extends StatelessWidget {
  final Function(String vaue) onSaved;

  const NewPostItemCount({Key key, this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onSaved: onSaved,
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
}

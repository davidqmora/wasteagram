import 'package:flutter/material.dart';

class WaitSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.3,
            alignment: Alignment.center,
            child: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                )),
          ),
        ),
      ],
    );
  }
}

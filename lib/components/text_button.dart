import 'package:flutter/material.dart';

import '../constants.dart';

class TextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color textColor;

  TextButton({this.text, this.onPressed, this.textColor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      splashColor: transparent,
      highlightColor: transparent,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 15.0,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

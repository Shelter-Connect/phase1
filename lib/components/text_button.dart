import 'package:flutter/material.dart';
import '../constants.dart';

class TextButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  TextButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          color: blueAccent,
          fontSize: 15.0,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

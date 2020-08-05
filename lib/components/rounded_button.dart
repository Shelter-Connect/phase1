import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;
  final Color textColor;

  RoundedButton({@required this.title, this.color, @required this.onPressed, this.textColor,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: FlatButton(
        color: color ?? colorScheme.secondary,
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants.dart';

class SecondaryRoundedButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  SecondaryRoundedButton({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: FlatButton(
        color: colorScheme.onSecondary,
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
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

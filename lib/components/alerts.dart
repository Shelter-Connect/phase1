import 'package:flutter/material.dart';

import '../constants.dart';

class NoActionAlert extends StatelessWidget {
  final String title;

  NoActionAlert({@required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Text(title),
      actions: [
        FlatButton(
          child: Text(
            'OK',
            style: TextStyle(color: colorScheme.secondary),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class SingleActionAlert extends StatelessWidget {
  final String title, subtitle, actionName;
  final VoidCallback action;

  SingleActionAlert({@required this.title, this.subtitle, @required this.action, @required this.actionName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Text(title),
      content: subtitle == null ? null : Text(subtitle, style: TextStyle(color: Colors.grey[700])),
      actions: [
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(color: colorScheme.secondary),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            actionName.toUpperCase(),
            style: TextStyle(color: colorScheme.secondary),
          ),
          onPressed: () {
            action();
            Navigator.pop(context);
          }
        )
      ],
    );
  }
}

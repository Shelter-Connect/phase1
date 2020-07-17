import 'package:flutter/material.dart';

import '../constants.dart';

class StandardLayout extends StatelessWidget {
  final String title, helpText;
  final Widget body;
  final Color color;

  StandardLayout({@required this.title, this.body, this.helpText = '', this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color ?? whiteBackground,
      appBar: AppBar(
        backgroundColor: color ?? whiteBackground,
        elevation: 0.0,
        title: Text(title),
        actions: <Widget>[
          Visibility(
            child: IconButton(
              icon: Icon(Icons.help),
              color: colorScheme.background,
              onPressed: () {
                _helpModalBottomSheet(context);
              },
            ),
            visible: this.helpText != '',
          ),
        ],
      ),
      body: body,
    );
  }

  void _helpModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                Text(
                  helpText,
                  style: subHeaderStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

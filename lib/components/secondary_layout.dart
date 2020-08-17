import 'package:flutter/material.dart';

import '../constants.dart';

class SecondaryLayout extends StatelessWidget {
  final String title, helpText;
  final Widget body;

  SecondaryLayout({
    @required this.title,
    this.body,
    this.helpText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleAccent,
      appBar: AppBar(
        backgroundColor: purpleAccent,
        elevation: 0.0,
        title: Text(
          title,
          style: TextStyle(
            color: purpleAccent,
          ),
        ),
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
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
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
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Help', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black)),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.help, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Text(helpText, style: TextStyle(fontSize: 17)),
              ],
            ),
          ),
        );
      },
    );
  }
}
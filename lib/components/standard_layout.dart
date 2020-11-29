import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class StandardLayout extends StatelessWidget {
  final String title, helpText;
  final Widget body;
  final Color color;
  final Color titleColor;

  StandardLayout({@required this.title, this.titleColor, this.body, this.helpText = '', this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color ?? Color(0xfff7f7f7),
      //Color(0xFFF5F5F5)
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: color ?? Color(0xfff7f7f7),
        //Color(0xFFF5F5F5)
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left, size: 35, color: purpleAccent),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900, fontSize: 25,
            color: purpleAccent ,
//              titleColor ?? Color(0xFFF5F5F5)
          ),
        ),
        actions: <Widget>[
          Visibility(
            child: IconButton(
              icon: Icon(Feather.help_circle),
              color: purpleAccent,
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
                      Text('Help', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.help),
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

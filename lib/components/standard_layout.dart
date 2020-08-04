import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class StandardLayout extends StatelessWidget {
  final String title, helpText;
  final Widget body;
  final Color color;

  StandardLayout({@required this.title, this.body, this.helpText = '', this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color ?? Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: color ?? Color(0xFFF5F5F5),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left, size: 35, color: purpleAccent),
        ),
        title: Text(title,
            style: TextStyle(
              color: Color(0xFFF5F5F5),
            )),
        actions: <Widget>[
          Visibility(
            child: IconButton(
              icon: Icon(Icons.help),
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
                        },icon: Icon(Icons.help),),
                    ],
                  ),
                ),
                Text(helpText, style: TextStyle(fontSize: 17)),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                        child: new Text('Report Issues', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17)),
                        onTap: () => launch('https://forms.gle/ue5idWtztcgevh9Q7')),
                    IconButton(
                      iconSize: 30,
                      onPressed: () {
                        launch('https://forms.gle/ue5idWtztcgevh9Q7');
                      },
                      icon: Icon(Icons.bug_report),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

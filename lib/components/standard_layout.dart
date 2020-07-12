import 'package:flutter/material.dart';


class StandardLayout extends StatelessWidget {
  final String title, drawerHeaderText;
  final bool menu, help;

  // TODO add more parameters for other things
  StandardLayout({@required this.title, this.menu=true, this.help=true, this.drawerHeaderText='drawerHeaderText',});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbbdefb),
      appBar: AppBar(
        leading: Visibility(
          child: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          maintainSize: false,
          visible: menu,
        ),
        title: Text(title),
        actions: <Widget>[
          Visibility(
            child: IconButton(
              icon: Icon(Icons.help),
              color: Colors.white,
              onPressed: () {
                _helpModalBottomSheet(context);
              },
            ),
            visible: help,
          ),
        ],
      ),
      // TODO: add body to Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(drawerHeaderText),
            ),
            ListTile( // TODO: add for loop functionality for more options
              title: Text('Example Option 1'),
              onTap: () {},
            ),
          ],
        ),
      ),
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
                Text('Example help text. Example help text. Example help text. Example help text. Example help text. Example help text. Example help text. Example help text. '),
              ],
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

class StandardLayout extends StatelessWidget { // TODO: UI changes
  final String title, drawerHeaderText, helpText;
  final bool menu, help;
  final Widget body;
  final List drawerOptions;

  // TODO: add more parameters for other things
  StandardLayout({
    @required this.title,
    this.body,
    this.menu = true,
    this.drawerHeaderText = '',
    this.drawerOptions, // TODO: change format from list to something else
    this.help = true,
    this.helpText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: body,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(drawerHeaderText),
            ),
            for (var option in drawerOptions) ListTile(
              title: Text(option[0]),
              onTap: () {Navigator.pushNamed(context, option[2]);}
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
                Text(helpText),
              ],
            ),
          ),
        );
      },
    );
  }
}

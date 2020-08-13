import 'package:flutter/material.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/pages/volunteer/volunteer_settings_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../navigation_tab.dart';
import '../volunteer/current_deliveries_page.dart';
import '../volunteer/discover_page.dart';
import '../volunteer/volunteer_settings_page.dart';

class VolunteerNavigationPage extends StatefulWidget {
  @override
  _VolunteerNavigationPageState createState() => _VolunteerNavigationPageState();
}

class _VolunteerNavigationPageState extends State<VolunteerNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _pages = [
//    OrganizationDiscover(),
//    CurrentDeliveriesPage(),
//    VolunteerSettingsPage(), //TODO Fix if messed up
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserPosition>(
      create: (_) => UserPosition(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: colorScheme.background,
          appBar: AppBar(
            brightness: Brightness.light,
            title: Text(
              _pages[_selectedIndex].title,
              style: TextStyle(color: Color(0xFFF5F5F5)),
            ),
            backgroundColor: Color(0xFFF5F5F5),
            elevation: 0.0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                color: purpleAccent,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            actions: <Widget>[
              Visibility(
                visible: _pages[_selectedIndex].helpDescription != '',
                child: IconButton(
                  icon: Icon(Icons.help),
                  color: purpleAccent,
                  onPressed: () {
                    _helpModalBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        DrawerHeader(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Linkare',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(Provider.of<User>(context, listen: false).user.email),
                            ],
                          ),
                        ),
                        ..._pages
                            .asMap()
                            .map(
                              (index, tab) => MapEntry(
                                index,
                                ListTile(
                                  title: Text(tab.title),
                                  leading: Icon(tab.icon),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text('Give Feedback'),
                    leading: Icon(
                      Icons.feedback,
                      color: Colors.orange,
                    ),
                    onTap: () {
                      launch('https://forms.gle/WjpQoEBNmBEQXoDP8');
                    },
                  ),
                ],
              ),
            ),
          ),
          body: _pages[_selectedIndex],
        ),
      ),
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
                Text(_pages[_selectedIndex].helpDescription, style: TextStyle(fontSize: 17)),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      child: new Text(
                        'Report Issues',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      onTap: () => launch('https://forms.gle/ue5idWtztcgevh9Q7'),
                    ),
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

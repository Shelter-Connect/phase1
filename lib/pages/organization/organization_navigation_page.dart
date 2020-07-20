import 'package:flutter/material.dart';
import 'package:phase1/pages/volunteer/settings_page.dart';

import '../../components/alerts.dart';
import '../../constants.dart';
import '../navigation_tab.dart';
import 'organization_contact_us.dart';
import 'organization_dashboard_page.dart';
import 'organization_expected_deliveries_page.dart';

class OrganizationNavigationPage extends StatefulWidget {
  @override
  _OrganizationNavigationPageState createState() => _OrganizationNavigationPageState();
}

class _OrganizationNavigationPageState extends State<OrganizationNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _pages = [
    OrganizationDashboardPage(),
    OrganizationExpectedDeliveriesPage(),
    SettingsPage(),
    OrganizationContactUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: whiteBackground,
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(
            _pages[_selectedIndex].title,
            style: TextStyle(color: purpleAccent),
          ),
          backgroundColor: whiteBackground,
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
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawerHeader(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shelter Connect',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('useremail@email.com'),
                          ],
                        ),
                      ),
                      ..._pages
                          .asMap()
                          .map((index, tab) => MapEntry(
                              index,
                              ListTile(
                                  title: Text(tab.title),
                                  leading: Icon(tab.icon),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    Navigator.pop(context);
                                  })))
                          .values
                          .toList(),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => SingleActionAlert(
                        title: 'Sign Out?',
                        subtitle: 'Your login information will not be remembered.',
                        actionName: 'Sign Out',
                        action: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          auth.signOut();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: _pages[_selectedIndex],
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
                Text(_pages[_selectedIndex].helpDescription, style: subHeaderStyle),
              ],
            ),
          ),
        );
      },
    );
  }
}

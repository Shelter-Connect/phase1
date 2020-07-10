import 'package:flutter/material.dart';

import 'organization_dashboard_page.dart';
import 'organization_expected_deliveries_page.dart';
import 'navigation_tab.dart';

class OrganizationNavigationPage extends StatefulWidget {
  @override
  _OrganizationNavigationPageState createState() => _OrganizationNavigationPageState();
}

class _OrganizationNavigationPageState extends State<OrganizationNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _pages = [
    OrganizationDashboardPage(),
    OrganizationExpectedDeliveriesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffacc0e6),
      appBar: AppBar(
        title: Text(_pages[_selectedIndex].title),
        backgroundColor: Color(0xffacc0e6),
        elevation: 0.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: <Widget>[
          Visibility(
            child: IconButton(
              icon: Icon(Icons.help),
              color: Colors.white,
              onPressed: () {
                _helpModalBottomSheet(context);
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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
            ..._pages.asMap().map((index, tab) => MapEntry(index, ListTile(
                title: Text(tab.title),
                leading: Icon(tab.icon),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.pop(context);
                }
            ))).values.toList(),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
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
                Text(_pages[_selectedIndex].helpDescription),
              ],
            ),
          ),
        );
      },
    );
  }
}
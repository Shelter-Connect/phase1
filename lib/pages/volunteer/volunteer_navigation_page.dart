import 'package:flutter/material.dart';

import '../../constants.dart';
import '../navigation_tab.dart';
import '../volunteer/donation_opportunities_page.dart';
import '../volunteer/volunteer_items_to_deliver_page.dart';
import 'volunteer_account_settings.dart';

class VolunteerNavigationPage extends StatefulWidget {
  @override
  _VolunteerNavigationPageState createState() => _VolunteerNavigationPageState();
}

class _VolunteerNavigationPageState extends State<VolunteerNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _pages = [
    DonationOpportunities(),
    ItemsToDeliverPage(),
    VolunteerAccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          _pages[_selectedIndex].title,
          style: TextStyle(
            color: Color(0xFFDAE5F9),
          ),
        ),
        backgroundColor: Color(0xFFDAE5F9),
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
              color: colorScheme.onSecondary,
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

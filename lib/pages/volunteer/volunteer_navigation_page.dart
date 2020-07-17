import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../navigation_tab.dart';
import '../volunteer/donation_opportunities_page.dart';
import '../volunteer/items_to_deliver_page.dart';
import 'settings_page.dart';

class VolunteerNavigationPage extends StatefulWidget {
  @override
  _VolunteerNavigationPageState createState() => _VolunteerNavigationPageState();
}

class _VolunteerNavigationPageState extends State<VolunteerNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _pages = [
    DonationOpportunities(),
    ItemsToDeliverPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          title: Text(
            _pages[_selectedIndex].title,
            style: TextStyle(
              color: whiteBackground,
            ),
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
          child: Column(
            children: <Widget>[
              Expanded(
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
                          SizedBox(height: 10.0),
                          Text(Provider.of<User>(context).user?.email ?? ' '),
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
              Container(
                child: Align(alignment: FractionalOffset.bottomCenter, child: Container(child: LogoutButton())),
                padding: const EdgeInsets.symmetric(vertical: 25.0),
              )
            ],
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
                Text(_pages[_selectedIndex].helpDescription),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: () {
          auth.signOut();
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
        child: Container(
          height: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: colorScheme.error,
          ),
          child: Center(
            child: Text(
              'Sign Out',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: colorScheme.onSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

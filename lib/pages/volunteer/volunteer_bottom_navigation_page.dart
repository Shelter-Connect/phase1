import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/pages/feedback_form.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/pages/volunteer/discover_page.dart';
import 'package:phase1/pages/volunteer/volunteer_settings_page.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../volunteer/current_deliveries_page.dart';
import '../volunteer/volunteer_settings_page.dart';

class VolunteerBottomNavigationPage extends StatefulWidget {
  @override
  _VolunteerBottomNavigationPageState createState() => _VolunteerBottomNavigationPageState();
}

class _VolunteerBottomNavigationPageState extends State<VolunteerBottomNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _tabs = [
    OrganizationDiscover(),
    CurrentDeliveriesPage(),
    FeedbackForm(),
    VolunteerSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserPosition>(
      create: (_) => UserPosition(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Color(0xfff5f5f5),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 4.0, top: 8.0),
                        child: Text(_tabs[_selectedIndex].barTitle, style: appBarTitleStyle),
                      ),
                      Visibility(
                        visible: _tabs[_selectedIndex].helpDescription != '',
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
                  _tabs[_selectedIndex],
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 50,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              iconSize: 25,
              selectedFontSize: 0,
              selectedItemColor: Color(0xFF6576EC),
              unselectedItemColor: Colors.black12,
              unselectedFontSize: 0,
              items: [
                ..._tabs
                    .asMap()
                    .map(
                      (index, tab) => MapEntry(
                          index,
                          BottomNavigationBarItem(
                            icon: Icon(tab.icon),
                            title: Text(tab.title),
                          )),
                    )
                    .values
                    .toList(),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
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
                Text(_tabs[_selectedIndex].helpDescription, style: TextStyle(fontSize: 17)),
              ],
            ),
          ),
        );
      },
    );
  }
}

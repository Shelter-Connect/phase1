import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/pages/organization/create_request_page.dart';
import '../feedback_form.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/pages/organization/current_requests_page.dart';
import 'package:phase1/pages/organization/expected_deliveries_page.dart';
import 'package:phase1/pages/organization/organization_settings_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../constants.dart';

class OrganizationBottomNavigationPage extends StatefulWidget {
  @override
  _OrganizationBottomNavigationPageState createState() => _OrganizationBottomNavigationPageState();
}

class _OrganizationBottomNavigationPageState extends State<OrganizationBottomNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _tabs = [
    ExpectedDeliveriesPage(),
    CurrentRequestsPage(),
    FeedbackForm(),
    OrganizationSettingsPage(),
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 4.0, top: 8.0),
                          child: Text(_tabs[_selectedIndex].barTitle, style: mainTitleStyle),
                        ),
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
              )
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            iconSize: 25,
            selectedFontSize: 0,
            selectedItemColor: purpleAccent,
            unselectedItemColor: Color(0xFFBEBEBE),
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
floatingActionButton: SpeedDial(
  // both default to 16
  marginRight: 25,
  marginBottom: 20,
  animatedIcon: AnimatedIcons.menu_close,
  animatedIconTheme: IconThemeData(size: 22.0),
  // this is ignored if animatedIcon is non null
  // child: Icon(Icons.add),
//  visible: _dialVisible,
  // If true user is forced to close dial manually
  // by tapping main button and overlay is not rendered.
  closeManually: false,
  curve: Curves.bounceIn,
  overlayColor: Colors.black,
  overlayOpacity: 0.05,
  tooltip: 'Choose the type of item to request',
  heroTag: 'speed-dial-hero-tag',
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  elevation: 2.0,
  shape: CircleBorder(),
  children: [
    SpeedDialChild(
      child: Icon(Icons.add),
      backgroundColor: purpleAccent,
      label: 'Create Request',
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () => print('SECOND CHILD'),
    ),
    SpeedDialChild(
        child: Icon(Icons.category),
        backgroundColor: Colors.greenAccent,
        label: 'Create Custom Item',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => print('FIRST CHILD')
    ),
    SpeedDialChild(
      child: Icon(Icons.content_paste),
      backgroundColor: Color(0xFF5546EC),
      label: 'View Cart',
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () => print('THIRD CHILD'),
    ),
  ],
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
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/pages/organization/current_requests_page.dart';
import 'package:phase1/pages/organization/expected_deliveries_page.dart';
import 'package:phase1/pages/organization/organization_home.dart';
import 'package:phase1/pages/organization/organization_settings_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
class OrganizationBottomNavigationPage extends StatefulWidget {
  @override
  _OrganizationBottomNavigationPageState createState() => _OrganizationBottomNavigationPageState();
}

class _OrganizationBottomNavigationPageState extends State<OrganizationBottomNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _tabs = [
    OrganizationHome(),
    ExpectedDeliveriesPage(),
    CurrentRequestsPage(),
    OrganizationSettingsPage(),

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
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            title: Text(
              _tabs[_selectedIndex].title,
              style: mainTitleStyle2,
            ),
            backgroundColor: Color(0xFFF5F5F5),
            elevation: 0.0,
            actions: <Widget>[
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
              IconButton(
                icon: Icon(Icons.feedback,
                    color: Colors.orange),
                onPressed: () {
                  _feedbackModalBottomSheet(context);
                },
              ),
            ],
          ),
          body: _tabs[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex : _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            iconSize: 25,
            selectedFontSize: 15,
            selectedItemColor: purpleAccent,
            unselectedItemColor: Color(0xFFBEBEBE),
            unselectedFontSize: 15,
            items: [
              ..._tabs
                  .asMap()
                  .map(
                    (index, tab) => MapEntry(
                    index,
                    BottomNavigationBarItem(
                      icon: Icon(tab.icon),
                      title: Text(tab.title),

                    )
                ),
              )
                  .values
                  .toList(),
            ],
            onTap: (index){
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  void _feedbackModalBottomSheet(BuildContext context) {
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
                      Text('Give Feedback', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.feedback),
                      ),
                    ],
                  ),
                ),
                Text('Give us feedback', style: TextStyle(fontSize: 17)),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      child: new Text(
                        'Give Feedback',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      onTap: () {
                        launch('https://forms.gle/WjpQoEBNmBEQXoDP8');
                      },
                    ),
                    IconButton(
                      iconSize: 30,
                      onPressed: () {
                        launch('https://forms.gle/WjpQoEBNmBEQXoDP8');
                      },
                      icon: Icon(Icons.feedback),
                    ),
                  ],
                ),
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
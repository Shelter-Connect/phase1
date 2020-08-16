import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/feedback_form.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/pages/organization/organization_bottom_navigation.dart';
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
          backgroundColor: colorScheme.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            title: Text(
              _tabs[_selectedIndex].title,
              style: TextStyle(color: Colors.transparent),
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
//              IconButton(
//                icon: Icon(Icons.feedback,
//                  color: Colors.orange),
//                onPressed: () {
//                  showDialog(
//                    context: context,
//                    builder: (_) => SingleActionAlert(
//                      title: 'Feedback',
//                      subtitle:
//                      'Do you have a bug that you want to report or would like to suggest a feature that would make your user experience better? Give feedback below!',
//                      actionName: 'Give Feedback',
//                      action: () {
//                        launch('https://forms.gle/WjpQoEBNmBEQXoDP8');
//                      },
//                    ),
//                  );
//                },
//              ),
            ],
          ),
          body: _tabs[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
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

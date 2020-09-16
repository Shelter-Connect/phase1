import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/pages/organization/create_request_page.dart';
import 'package:phase1/pages/organization/current_requests_page.dart';
import 'package:phase1/pages/organization/expected_deliveries_page.dart';
import 'package:phase1/pages/organization/organization_settings_page.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../feedback_form.dart';

class OrganizationNavigationPage extends StatefulWidget {
  @override
  _OrganizationNavigationPageState createState() => _OrganizationNavigationPageState();
}

class _OrganizationNavigationPageState extends State<OrganizationNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _tabs = [
    CurrentRequestsPage(),
    ExpectedDeliveriesPage(),
    FeedbackForm(),
    OrganizationSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Donation>>.value(
          value: FirestoreHelper.getCurrentOrganizationReference(context).collection('currentDonations').orderBy('date').snapshots().map((snapshot) {
            if (snapshot.documents.length == 0) return [];
            if (snapshot == null) return null;
            List<Donation> donations = [];
            for (DocumentSnapshot document in snapshot.documents) {
              donations.add(Donation.fromFirestoreMap(document));
            }
            return donations;
          }),
        ),
      ],
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
                        child: Text(_tabs[_selectedIndex].barTitle, style: appBarTitleStyle),
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
            )),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: purpleAccent,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRequestPage()));
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height / 14 + 2,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              iconSize: 25,
              selectedFontSize: 0,
              selectedItemColor: purpleAccent,
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
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

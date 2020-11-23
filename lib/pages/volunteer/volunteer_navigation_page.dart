import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:phase1/components/floating_text_field.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/components/rounded_button.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/past_donation.dart';
import 'package:phase1/models/user.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/pages/navigation_tab.dart';
import 'package:phase1/pages/volunteer/discover_page.dart';
import 'package:phase1/pages/volunteer/volunteer_settings_page.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../volunteer/current_deliveries_page.dart';
import '../volunteer/volunteer_settings_page.dart';

class VolunteerNavigationPage extends StatefulWidget {
  @override
  _VolunteerNavigationPageState createState() => _VolunteerNavigationPageState();
}

class _VolunteerNavigationPageState extends State<VolunteerNavigationPage> {
  int _selectedIndex = 0;
  final List<NavigationTab> _tabs = [
    OrganizationDiscover(),
    CurrentDeliveriesPage(),
//    FeedbackForm(),
    VolunteerSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    TimeOfDay open = new TimeOfDay.now(), closed = new TimeOfDay.now();
    return ChangeNotifierProvider<UserPosition>(
      create: (_) => UserPosition(),
      child: MultiProvider(
        providers: [
          StreamProvider<List<Organization>>.value(
            value: db.collection('organizations').snapshots().map((snapshot) {
              if (snapshot.documents.length == 0) return [];
              if (snapshot == null) return null;
              List<Organization> organizations = [];
              for (DocumentSnapshot document in snapshot.documents) {
                if (document.documentID == 'bVRQfZpizSQWty24zFgFqIrB60i2') continue;
                organizations.add(Organization.fromFirestoreMap(context: context, organizationSnapshot: document, isVolunteer: false));
              }
              return organizations;
            }),
          ),
          StreamProvider<List<Donation>>.value(
            value: FirestoreHelper.getCurrentVolunteerReference(context).collection('currentDonations').orderBy('date').snapshots().map((snapshot) {
              if (snapshot.documents.length == 0) return [];
              if (snapshot == null) return null;
              List<Donation> donations = [];
              for (DocumentSnapshot document in snapshot.documents) {
                if (document.documentID == 'categories') continue;
                donations.add(Donation.fromFirestoreMap(document));
              }
              return donations;
            }),
          ),
          StreamProvider<List<PastDonation>>.value(
            value: FirestoreHelper.getCurrentVolunteerReference(context).collection('pastDonations').orderBy('date').snapshots().map((snapshot) {
              if (snapshot.documents.length == 0) return [];
              if (snapshot == null) return null;
              List<PastDonation> donations = [];
              for (DocumentSnapshot document in snapshot.documents) {
                if (document.documentID == 'categories') continue;
                donations.add(PastDonation.fromFirestoreMap(document));
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 4.0, top: 8.0),
                          child: Text(_tabs[_selectedIndex].barTitle, style: appBarTitleStyle),
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: _tabs[_selectedIndex].helpDescription != '',
                              child: IconButton(
                                icon: Icon(Feather.help_circle),
                                color: purpleAccent,
                                onPressed: () {
                                  _helpModalBottomSheet(context);
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              icon: Icon(Feather.thumbs_up),
                              color: purpleAccent,
                              onPressed: () {
                                _helpModalBottomSheet2(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    _tabs[_selectedIndex],
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
//              purpleAccent,
              iconSize: 25,
              selectedItemColor: purpleAccent,
//              colorScheme.onSecondary
              unselectedItemColor: purpleAccent,
              //Colors.black12,
              items: [
                ..._tabs
                    .asMap()
                    .map(
                      (index, tab) => MapEntry(
                          index,
                          BottomNavigationBarItem(
                            icon: tab.icon,
                            title: Text(tab.title),
                            activeIcon: tab.activeIcon,
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

void _helpModalBottomSheet2(BuildContext context) {
  TextEditingController bug = TextEditingController(), improvement = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (BuildContext bc) {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Feedback', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Feather.thumbs_up),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      FloatingDescriptionField(
                        height: 150,
                        maxLength: 1500,
                        controller: bug,
                        maxLines: null,
                        labelText: ('Please report any bugs here.'),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        counterText: '',
                      ),
                      SizedBox(height: 20),
                      FloatingDescriptionField(
                        height: 150,
                        maxLength: 1500,
                        controller: improvement,
                        maxLines: null,
                        labelText: ('What do you think we can improve on?'),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        counterText: '',
                      ),
                      SizedBox(height: 20),
                      RoundedButton(
                        title: 'Submit Feedback',
                        onPressed: () {
                          db.collection('feedback').add(
                            {'bug': bug.text, 'improvement': improvement.text, 'email': Provider.of<User>(context, listen: false).user.email},
                          );
                          bug.clear();
                          improvement.clear();
                          FlushBar(message: 'Thank you for the feedback!', duration: Duration(seconds: 3)).build(context);
                        },
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

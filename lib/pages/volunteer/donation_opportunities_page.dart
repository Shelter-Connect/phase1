import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/pages/volunteer/donation_filter_page.dart';

import '../../components/organization_donation_profile.dart';
import '../../constants.dart';
import '../navigation_tab.dart';

class DonationOpportunities extends StatefulWidget with NavigationTab {
  @override
  _DonationOpportunitiesState createState() => _DonationOpportunitiesState();

  @override
  String get helpDescription => 'This is a help description for the volunteer: donation opportunities page!';

  @override
  IconData get icon => Icons.home;

  @override
  String get title => 'Donation Opportunities';
}

class _DonationOpportunitiesState extends State<DonationOpportunities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Donation Opportunities',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: colorScheme.onSecondary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonationFilterPage()),
                  );
                },
                child: IntrinsicWidth(
                  child: Row(
                    children: <Widget>[
                      Text('Filter', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: purpleAccent)),
                      SizedBox(width: 5.0),
                      Column(
                        children: [
                          SizedBox(height: 5.0),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: purpleAccent,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            StreamBuilder(
              stream: db.collection('organizations').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                List<Widget> widgets = [];
                for (DocumentSnapshot organizationSnapshot in snapshot.data.documents) {
                  if (organizationSnapshot['requestCategories'] != null) {
                    widgets.add(OrganizationDonationProfile(
                      name: organizationSnapshot['name'],
                      description: organizationSnapshot['description'],
                      distance: 6.9,
                      requestCategories: organizationSnapshot['itemCategories'].cast<String>(),
                    ));
                  }
                }
                return Column(
                  children: widgets,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

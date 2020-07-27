import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phase1/components/donation_filter_button.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:phase1/services/location_helper.dart';

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
  Position userPosition;

  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      setState(() {
        userPosition = position;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground,
      body: userPosition == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                  Padding(padding: const EdgeInsets.only(left: 16.0), child: DonationFilterButton()),
                  SizedBox(height: 20.0),
                  StreamBuilder(
                    stream: db.collection('organizations').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      List<Widget> widgets = [];
                      for (DocumentSnapshot organizationSnapshot in snapshot.data.documents) {
                        if (organizationSnapshot['itemCategories'] != null) {
                          Organization organization = FirestoreHelper.getOrganization(
                              context: context,
                              organizationId: organizationSnapshot.documentID,
                              userPosition: userPosition,
                              organizationSnapshot: organizationSnapshot);
                          widgets.add(OrganizationDonationProfile(organization: organization));
                        }
                      }
                      widgets.sort((a, b) {
                        return (a as OrganizationDonationProfile)
                            .organization
                            .distance
                            .compareTo((b as OrganizationDonationProfile).organization.distance);
                      });
                      for (int i = 1; i < widgets.length; i++) {
                        widgets.insert(
                          i++,
                          SizedBox(height: 16.0),
                        );
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

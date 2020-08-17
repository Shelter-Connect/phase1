import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';

import '../../components/organization_donation_profile.dart';
import '../../constants.dart';
import '../navigation_tab.dart';

class OrganizationDiscover extends StatefulWidget with NavigationTab {
  @override
  _OrganizationDiscoverState createState() => _OrganizationDiscoverState();

  @override
  String get helpDescription => 'This is the Organization Discover page. Here, you can see nearby organizations in need of donations. '
      'To see more information about an organization, or to sign up for a donation, click on an organization. ';

  @override
  IconData get icon => Icons.search;

  @override
  String get title => 'Discover';
}

class _OrganizationDiscoverState extends State<OrganizationDiscover> {
  bool hasPosition = true;

  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      Provider.of<UserPosition>(context, listen: false).position = position;
    }).catchError((error) {
      if (Provider.of<UserPosition>(context, listen: false).position == null) {
        setState(() {
          hasPosition = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
              child: Text('Discover', style: mainTitleStyle),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: db.collection('organizations').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || (Provider.of<UserPosition>(context).position == null && hasPosition)) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Widget> widgets = [];
                for (DocumentSnapshot organizationSnapshot in snapshot.data.documents) {
                  Organization organization =
                      Organization.fromFirestoreMap(context: context, organizationSnapshot: organizationSnapshot, isVolunteer: true);
                  widgets.add(
                    OrganizationDonationProfile(organization: organization),
                  );
                }
                if (hasPosition) {
                  widgets.sort((a, b) {
                    if (((a as OrganizationDonationProfile).organization.itemCategories == null) ||
                        ((a as OrganizationDonationProfile).organization.itemCategories.length == 0))
                      return 1;
                    else if (((b as OrganizationDonationProfile).organization.itemCategories == null) ||
                        ((b as OrganizationDonationProfile).organization.itemCategories.length == 0)) return -1;
                    return (a as OrganizationDonationProfile)
                        .organization
                        .distance
                        .compareTo((b as OrganizationDonationProfile).organization.distance);
                  });
                }
                for (int i = 1; i < widgets.length; i++) {
                  widgets.insert(
                    i++,
                    SizedBox(height: 20.0),
                  );
                }
                return Column(
                  children: widgets,
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

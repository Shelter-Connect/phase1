import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../components/organization_donation_profile.dart';
import '../../constants.dart';
import '../bottom_navigation_tab.dart';
import '../navigation_tab.dart';

class OrganizationDiscover extends StatefulWidget with BottomNavigationTab { //TODO Fix if errrs
  @override
  _OrganizationDiscoverState createState() => _OrganizationDiscoverState();

  @override
  String get helpDescription => 'This is the Organization Discover page. Here, you can see nearby organizations in need of donations. '
      'To see more information about an organization, or to sign up for a donation, click on an organization. ';

  @override
  IconData get icon => Icons.search;

  @override
  String get title => 'Discover';

  @override
  String get barTitle => 'Discover';


}

class _OrganizationDiscoverState extends State<OrganizationDiscover> {
  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      Provider.of<UserPosition>(context, listen: false).position = position;
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
            SizedBox(height: 20.0),
            StreamBuilder(
              stream: db.collection('organizations').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || Provider.of<UserPosition>(context).position == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Widget> widgets = [];
                for (DocumentSnapshot organizationSnapshot in snapshot.data.documents) {
                  if (organizationSnapshot['itemCategories'] != null) {
                    Organization organization =
                        Organization.fromFirestoreMap(context: context, organizationSnapshot: organizationSnapshot, isVolunteer: true);
                    widgets.add(
                      OrganizationDonationProfile(organization: organization),
                    );
                  }
                }
                widgets.sort((a, b) {
                  return (a as OrganizationDonationProfile).organization.distance.compareTo((b as OrganizationDonationProfile).organization.distance);
                });
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

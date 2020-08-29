import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  IconData get icon => Icons.home;

  @override
  String get title => 'Linkare';

  @override
  String get barTitle => 'Linkare';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StreamBuilder(
          stream: db.collection('organizations').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || (Provider.of<UserPosition>(context).position == null && hasPosition)) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data.documents == null) {
              return Column(
                children: [
                  Text(
                    'There are no organizations on the app yet, but please stick around! There are many organizations eager to start requesting!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                        child: SvgPicture.asset('assets/ui_svgs/searching.svg',
                          semanticsLabel: 'Go Discover More Organizations to Help!',
                          width: MediaQuery.of(context).size.width,
                        ),
                      )
                  ),
                  SizedBox(height: 20),
                ],
              );
            }
            List<Widget> widgets = [];
            for (DocumentSnapshot organizationSnapshot in snapshot.data.documents) {
              if (organizationSnapshot['itemCategories'] != null && organizationSnapshot['itemCategories'].length != 0) {
                Organization organization =
                    Organization.fromFirestoreMap(context: context, organizationSnapshot: organizationSnapshot, isVolunteer: true);
                widgets.add(
                  OrganizationDonationProfile(organization: organization),
                );
              }
            }
            if (hasPosition) {
              widgets.sort((a, b) {
                return (a as OrganizationDonationProfile).organization.distance.compareTo((b as OrganizationDonationProfile).organization.distance);
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
    );
  }
}

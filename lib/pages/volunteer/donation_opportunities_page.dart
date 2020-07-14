import 'package:flutter/material.dart';

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
      backgroundColor: blueBackground,
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
                  //TODO Navigate to donation_filter page
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
            OrganizationDonationProfile(
              name: 'City Team Men\'s Shelter',
              distance: 5.2,
              description:
                  'Lorem ipsum dolor sit amet, sed eu mollis tibique. Cu decore nominavi splendide vel. Sit mazim simul feugait ea. Te usu nullam populo vivendo. Lorem ipsum dolor sit amet, sed eu mollis tibique.',
            ),
            SizedBox(height: 20.0),
            OrganizationDonationProfile(
              name: 'HomeFirst',
              distance: 6.9,
              description:
                  'Lorem ipsum dolor sit amet, sed eu mollis tibique. Cu decore nominavi splendide vel. Sit mazim simul feugait ea. Te usu nullam populo vivendo. Lorem ipsum dolor sit amet, sed eu mollis tibique.',
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

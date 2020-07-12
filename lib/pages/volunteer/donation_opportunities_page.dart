import 'package:flutter/material.dart';
import 'org_donation_oppo_profile.dart';
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
      backgroundColor: Color(0xFFDAE5F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Text(
                'Donation Opportunities',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Color(0xFF6576EC)),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                onPressed: () {
                  //TODO Navigate to donation_filter page
                },
                child: Container(
                  width: 92,
                  child: Row(
                    children: <Widget>[
                      Text('Filters', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xFF6576EC))),
                      Icon(Icons.keyboard_arrow_down, color: Color(0xFF6576EC), size: 35,),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ShelterDonationProfile('City Team Men\'s Shelter', 5.2, 'Lorem ipsum dolor sit amet, sed eu mollis tibique. Cu decore nominavi splendide vel. Sit mazim simul feugait ea. Te usu nullam populo vivendo. Lorem ipsum dolor sit amet, sed eu mollis tibique.'),
            SizedBox(height: 15),
            ShelterDonationProfile('HomeFirst', 2.5, 'Lorem ipsum dolor sit amet, sed eu mollis tibique. Cu decore nominavi splendide vel. Sit mazim simul feugait ea. Te usu nullam populo vivendo. Lorem ipsum dolor sit amet, sed eu mollis tibique.'),
            SizedBox(height: 15),
            ShelterDonationProfile('Lifemoves', 8.9, 'Lorem ipsum dolor sit amet, sed eu mollis tibique. Cu decore nominavi splendide vel. Sit mazim simul feugait ea. Te usu nullam populo vivendo. Lorem ipsum dolor sit amet, sed eu mollis tibique.'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
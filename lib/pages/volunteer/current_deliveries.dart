import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phase1/components/deliveries_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:phase1/services/location_helper.dart';

import '../navigation_tab.dart';

class CurrentDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _CurrentDeliveriesPageState createState() => _CurrentDeliveriesPageState();

  @override
  String get helpDescription => 'This is a help description for the volunteer current deliveries';

  @override
  IconData get icon => Icons.local_shipping;

  @override
  String get title => 'Items To Deliver';
}

class _CurrentDeliveriesPageState extends State<CurrentDeliveriesPage> {
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
    return userPosition == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: whiteBackground,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Items to Deliver',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
                    ),
                    SizedBox(height: 20),
                    StreamBuilder(
                      stream: FirestoreHelper.getCurrentVolunteerReference(context).collection('currentDonations').snapshots(),
                      builder: (context, snapshot) {
                        return StreamBuilder(
                          stream: db.collection('organizations').snapshots(),
                          builder: (context, snapshot2) {
                            if ((!snapshot2.hasData) || (!snapshot.hasData)) {
                              return CircularProgressIndicator();
                            }
                            List<Widget> widgets = [];
                            for (DocumentSnapshot donationSnapshot in snapshot.data.documents) {
                              if (donationSnapshot.exists) {
                                for (DocumentSnapshot organizationSnapshot in snapshot2.data.documents) {
                                  if ((organizationSnapshot.exists) && (organizationSnapshot.documentID == donationSnapshot['organizationId'])) {
                                    Organization organization = FirestoreHelper.getOrganization(
                                        context: context,
                                        organizationId: donationSnapshot['organizationId'],
                                        userPosition: userPosition,
                                        organizationSnapshot: organizationSnapshot);
                                    Donation donation = FirestoreHelper.getDonation(
                                        context: context, donationId: donationSnapshot.documentID, donationSnapshot: donationSnapshot);
                                    widgets.add(DeliveriesContainer(organization: organization, donation: donation));
                                  }
                                }
                              }
                            }
                            widgets.sort((a, b) {
                              return (a as DeliveriesContainer).organization.distance.compareTo((b as DeliveriesContainer).organization.distance);
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
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
  }
}

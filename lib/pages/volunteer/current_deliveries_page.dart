import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phase1/components/deliveries_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      setState(() {
        Provider.of<UserPosition>(context, listen:false).position = position;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Provider.of<UserPosition>(context).position == null ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
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
                stream: FirestoreHelper.getCurrentVolunteerReference(context).collection('currentDonations').orderBy('date').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<Widget> widgets = [];
                  Position userPosition = Provider.of<UserPosition>(context, listen:false).position;
                  for (DocumentSnapshot donationSnapshot in snapshot.data.documents) {
                    Organization organization = Organization(
                      address: donationSnapshot['organizationAddress'],
                      location: Position(latitude: donationSnapshot['organizationLocation'].latitude, longitude: donationSnapshot['organizationLocation'].longitude),
                      email: donationSnapshot['organizationEmail'],
                      id: donationSnapshot.documentID,
                      description: donationSnapshot['organizationDescription'],
                      name: donationSnapshot['organizationName'],
                      distance: userPosition != null ? LocationHelper.distance(
                          donationSnapshot['organizationLocation'].latitude, donationSnapshot['organizationLocation'].longitude, userPosition.latitude, userPosition.longitude
                      ) : null,
                    );
                    Donation donation = Donation.fromFirestoreMap(context: context, donationSnapshot: donationSnapshot);
                    widgets.add(DeliveriesContainer(organization: organization, donation: donation));
                  }
                  for (int i = 1; i < widgets.length; i++) {
                    widgets.insert(
                      i++,
                      SizedBox(height: 16.0),
                    );
                  }
                  return Column(
                    children: widgets,
                  );
                }
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

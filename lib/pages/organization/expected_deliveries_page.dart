import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/expected_deliveries_container.dart';
import '../navigation_tab.dart';

class ExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _ExpectedDeliveriesPageState createState() => _ExpectedDeliveriesPageState();

  @override
  String get helpDescription => '''   This is the Organization Expected Deliveries Page! Here you can seee all the items that the volunteers have confirmed to deliver to your organization! 
  Click on each delivery to see more information regarding the arrival time, donor contact information, and much more!''';

  @override
  IconData get icon => Icons.access_time;

  @override
  String get title => 'Expected Deliveries';
}

class _ExpectedDeliveriesPageState extends State<ExpectedDeliveriesPage> {
  String dropdownValue = 'Sort by';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Expected Deliveries',
              style: mainTitleStyle,
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: FirestoreHelper.getCurrentOrganizationReference(context).collection('currentDonations').orderBy('date').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Widget> widgets = [];
                for (DocumentSnapshot document in snapshot.data.documents) {
                  widgets.add(ExpectedDeliveryContainer(
                    donation: Donation.fromFirestoreMap(document),
                  ));
                  widgets.add(SizedBox(height: 20.0));
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

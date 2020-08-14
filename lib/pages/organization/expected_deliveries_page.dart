import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/expected_deliveries_container.dart';
import '../navigation_tab.dart';
import 'create_request_page.dart';

class ExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _ExpectedDeliveriesPageState createState() => _ExpectedDeliveriesPageState();

  @override
  String get helpDescription =>
      'This is the Expected Deliveries page. Here, you can see any items that the volunteers have signed up to deliver to your organization. '
      'Click on a delivery to see more information regarding the items being delivered, the arrival time, and donor contact information.';

  @override
  IconData get icon => Icons.access_time;

  @override
  String get title => 'Deliveries';
}

class _ExpectedDeliveriesPageState extends State<ExpectedDeliveriesPage> {
  String dropdownValue = 'Sort by';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                stream: FirestoreHelper.getCurrentOrganizationReference(context).collection('currentDonations').orderBy('date').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data.documents.length == 0) {
                    return Column(
                      children: [
                        Text(
                          'Your organization currently does not have any expected deliveries.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Center(
                            child: SvgPicture.asset('assets/ui_svgs/dood.svg',
                              semanticsLabel: 'Create some requests!',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                      ],
                    );
                  }
                  List<Widget> widgets = [];
                  for (DocumentSnapshot document in snapshot.data.documents) {
                    widgets.add(
                      ExpectedDeliveryContainer(
                        donation: Donation.fromFirestoreMap(document),
                      ),
                    );
                    widgets.add(
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: purpleAccent,
        heroTag: 'create request',
        // Create request testing code
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRequestPage()),
          );
        },
        label: Text('New Request'),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

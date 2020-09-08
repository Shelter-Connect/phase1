import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/components/sync_calendar.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/expected_deliveries_container.dart';
import '../../constants.dart';
import '../navigation_tab.dart';

class ExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _ExpectedDeliveriesPageState createState() => _ExpectedDeliveriesPageState();

  @override
  String get helpDescription =>
      'This is the Expected Deliveries page. Here, you can see any items that the volunteers have signed up to deliver to your organization. '
      'Click on a delivery to see more information regarding the items being delivered, the arrival time, and donor contact information.'
      'The Sync button syncs your expected deliveries to a calendar of your choice';

  @override
  IconData get icon => Icons.access_time;

  @override
  String get title => 'Deliveries';

  @override
  String get barTitle => 'Expected Deliveries';
}

class _ExpectedDeliveriesPageState extends State<ExpectedDeliveriesPage> {
  String dropdownValue = 'Sort by';
  List<Donation> donations = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FlatButton(
              onPressed: () async {
                SyncCalendar(donations, true);
              },
              color: purpleAccent,
              padding: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                      ),
                    ),
                    Text('Sync', style: TextStyle(fontSize: 17, color: Colors.white))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
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
                        child: SvgPicture.asset(
                          'assets/ui_svgs/dood.svg',
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
                Donation donation = Donation.fromFirestoreMap(document);
                donations.add(donation);
                widgets.add(
                  ExpectedDeliveryContainer(
                    donation: donation,
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
    );
  }
}

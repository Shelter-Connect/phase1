import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phase1/components/deliveries_container.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/firestore_helper.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';

import '../navigation_tab.dart';

class CurrentDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _CurrentDeliveriesPageState createState() => _CurrentDeliveriesPageState();

  @override
  String get helpDescription =>
      'This page shows all the donations you have signed up for. Overdue deliveries are highlighted in red. Click on a delivery to see more information, '
      'or to edit or cancel the delivery. ';

  @override
  IconData get icon => Icons.local_shipping;

  @override
  String get title => 'Deliver';
}

class _CurrentDeliveriesPageState extends State<CurrentDeliveriesPage> {
  bool hasPosition = true;

  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      setState(() {
        Provider.of<UserPosition>(context, listen: false).position = position;
      });
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
    var now = new DateTime.now();
    var earlier = now.subtract(Duration(seconds: 5));
    assert(earlier.isBefore(now));
    assert(!now.isBefore(now));

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Provider.of<UserPosition>(context).position == null && hasPosition
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Items to Deliver', style: mainTitleStyle),
                    SizedBox(height: 20),
                    StreamBuilder(
                      stream: FirestoreHelper.getCurrentVolunteerReference(context).collection('currentDonations').orderBy('date').snapshots(),
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
                                'You have no items to deliver. Go makes some donations!',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                ),
                              ),
                              SizedBox(height: 40),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Center(
                                    child: SvgPicture.asset('assets/ui_svgs/deli.svg',
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
                        //Position userPosition = Provider.of<UserPosition>(context, listen: false).position;
                        for (DocumentSnapshot donationSnapshot in snapshot.data.documents) {
                          Donation donation = Donation.fromFirestoreMap(donationSnapshot);
                          widgets.add(
                            DeliveriesContainer(donation: donation),
                          );
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

import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/flushbar.dart';
import 'package:phase1/components/maps_sheet.dart';
import 'package:phase1/models/donation.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/services/firestore_helper.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';
import 'edit_delivery_page.dart';

class DeliveryDescriptionPage extends StatefulWidget {
  final Donation donation;

  DeliveryDescriptionPage(this.donation);

  @override
  _DeliveryDescriptionPageState createState() => _DeliveryDescriptionPageState();
}

class _DeliveryDescriptionPageState extends State<DeliveryDescriptionPage> {
  Donation donation;
  bool loading = false;

  @override
  void initState() {
    donation = widget.donation;
    updateOrganizationRequests();
    super.initState();
  }

  void updateOrganizationRequests() {
    setState(() {
      loading = true;
    });
    DocumentReference organizationReference = db.collection('organizations').document(donation.organization.id);
    organizationReference.collection('requests').getDocuments().then((documents) {
      donation.organization.requestedItems = Map();
      for (DocumentSnapshot document in documents.documents) {
        if (donation.organization.requestedItems[document['category']] == null) donation.organization.requestedItems[document['category']] = [];
        setState(() {
          donation.organization.requestedItems[document['category']].add(
            Item(
              name: document['name'],
              amount: document['amount'],
              category: document['category'],
              specificDescription: document['specificDescription'],
              unit: document['unit'],
            ),
          );
        });
      }
      MapLauncher.installedMaps.then((value) => availableMaps = value);
      coords = Coords(widget.donation.organization.location.latitude, widget.donation.organization.location.longitude);
      title = widget.donation.organization.address;
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: ' ',
      helpText: 'This page shows a delivery you have signed up for. Here, you can edit or cancel this delivery. ',
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Delivery to ${donation.organization.name}', style: mainTitleStyle),
                    SizedBox(height: 20),
                    OrganizationInformation(
                      orgEmail: donation.organization.email,
                      orgAddress: donation.organization.address,
                      dateTime: donation.date,
                    ),
                    SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Selected Donations',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                    ),
                                    FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      splashColor: transparent,
                                      highlightColor: transparent,
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: colorScheme.error,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditDeliveryPage(donation)))
                                            .then((newDonation) async {
                                          if (newDonation != null) {
                                            setState(() {
                                              loading = true;
                                            });
                                            List<Item> delta = List();
                                            for (Item newItem in newDonation.items) {
                                              Item item = newItem.clone();
                                              item.amount *= -1;
                                              delta.add(item);
                                            }
                                            FirestoreHelper.cancelVolunteerDelivery(context, donation);
                                            FirestoreHelper.updateRequests(
                                                context: context, items: delta, organizationId: newDonation.organization.id, isCreating: false);
                                            FirestoreHelper.createDonation(context, newDonation).then((value) => updateOrganizationRequests());
                                            setState(() {
                                              donation = newDonation;
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 5,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: purpleAccent,
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: donation.items.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(40)
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                '${donation.items[index].name} - ${donation.items[index].amount} ${donation.items[index].unit ?? ''}'
                                                    .trim(),
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (donation.items[index].specificDescription != null)
                                          Text(
                                            donation.items[index].specificDescription,
                                            style: TextStyle(fontSize: 14, color: Colors.grey),
                                          ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: 5)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => SingleActionAlert(
                            action: () {
                              FirestoreHelper.cancelVolunteerDelivery(context, donation);
                              Navigator.pop(context);
                              FlushBar(message: 'Your delivery has been cancelled', duration: Duration(seconds: 3)).build(context);
                            },
                            actionName: 'Cancel Delivery',
                            title: 'Cancel Delivery?',
                            subtitle: 'You cannot revert this action',
                          ),
                        );
                      },
                      child: Container(
                        height: 45.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: colorScheme.error,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.cancel, color: Colors.white, size: 28),
                              SizedBox(width: 5),
                              Text(
                                'Cancel Delivery',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class OrganizationInformation extends StatelessWidget {
  final String orgEmail;
  final String orgAddress;
  final DateTime dateTime;

  OrganizationInformation({@required this.orgEmail, @required this.orgAddress, @required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: ui.TextDirection.rtl,
                  children: [
                    FlatButton(
                        onPressed: () { MapSheet().build(context); },
                        child: SvgPicture.asset("assets/random_svgs/googlemaps.svg", height: 28,)
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'About This Organization',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                            color: purpleAccent,
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Email Address: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: orgEmail,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Donation Location: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: orgAddress,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Deliver By: ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '${DateFormat('MMMMd').format(dateTime)}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

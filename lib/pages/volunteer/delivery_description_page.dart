import 'dart:io' show Platform;
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class DeliveryDescriptionPage extends StatefulWidget {
  final Donation donation;

  DeliveryDescriptionPage(this.donation);

  @override
  _DeliveryDescriptionPageState createState() => _DeliveryDescriptionPageState();
}

class _DeliveryDescriptionPageState extends State<DeliveryDescriptionPage> {
  Donation donation;
  bool loading = false;
  // List<TapGestureRecognizer> _amazonLinksTapGestureRecognizers;

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
                urgency: document['urgency'],
                urgencyColor: (document['urgency'] == 0)
                    ? Colors.transparent
                    : (document['urgency'] == 1)
                        ? Colors.green
                        : (document['urgency'] == 2)
                            ? Colors.yellow
                            : Colors.red),
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
      helpText: 'This page shows a delivery you have signed up for. You can see the organization\'s information, location, and contact information. Underneath, '
          'you can see the exact information on your delivery. Here, you can edit or cancel this delivery.',
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Delivery to ${donation.organization.name}', style: mainTitleStyle),
                    ),
                    SizedBox(height: 20),
                    OrganizationInformation(
                      orgEmail: donation.organization.email,
                      orgAddress: donation.organization.address,
                      dateTime: donation.date,
                      schedule: donation.organization.schedule,
                    ),
                    SizedBox(height: 2),

                    // Card with the donations
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
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
                                      children: [
                                        Row(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      String itemName = donation.items[index].name;

                                                      // Convert to Amazon URL
                                                      String searchQuery = itemName.replaceAll(" ", "+");
                                                      String amazonURL = "https://www.amazon.com/s?k=" + searchQuery;
                                                      // Check that the Amazon URL will work
                                                      bool amazonURLCanLaunch = await canLaunch(amazonURL);

                                                      if (amazonURLCanLaunch) {
                                                        await Clipboard.setData(ClipboardData(text: donation.organization.address)); // Copy shipping address to clipboard
                                                        launch(amazonURL);
                                                      }
                                                    },
                                                    child: Text(
                                                      '${donation.items[index].name} - ${donation.items[index].amount} ${donation.items[index].unit ?? ''}'
                                                          .trim(),
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ),
                                                  if (donation.items[index].specificDescription != null)
                                                    Text(
                                                      donation.items[index].specificDescription,
                                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Container(
                                                  height: 12,
                                                  width: 12,
                                                  decoration: BoxDecoration(
                                                      color: donation.items[index].urgencyColor, borderRadius: BorderRadius.circular(40)),
                                                ),
                                              ),
                                            ),
                                          ],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: InkWell(
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
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class OrganizationInformation extends StatefulWidget {
  final String orgEmail;
  final String orgAddress;
  final DateTime dateTime;
  final Map<String, List<TimeOfDay>> schedule;

  OrganizationInformation({@required this.orgEmail, @required this.orgAddress, @required this.dateTime, @required this.schedule});

  @override
  _OrganizationInformationState createState() => _OrganizationInformationState();
}

class _OrganizationInformationState extends State<OrganizationInformation> {
  TapGestureRecognizer _addressTapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _addressTapGestureRecognizer = TapGestureRecognizer()..onTap = _addressHandleTap;
  }

  void _addressHandleTap() {
    MapSheet().build(context);
  }

  @override
  void dispose() {
    _addressTapGestureRecognizer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: ui.TextDirection.rtl,
                  children: [
                    FlatButton(
                        onPressed: () {
                          MapSheet().build(context);
                        },
                        child: SvgPicture.asset(
                          Platform.isIOS ? "assets/random_svgs/applemaps.svg" : "assets/random_svgs/googlemaps.svg",
                          height: 28,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'About this Organization',
                            style: TextStyle(
                              fontSize: Platform.isIOS ? 19 : 20,
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
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                                  text: widget.orgEmail,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ))
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
                                  text: widget.orgAddress,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                  ),
                                  recognizer: _addressTapGestureRecognizer)
                            ],
                          ),
                        ),
                        if (widget.schedule != null) RichText(
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
                                text: '${DateFormat('MMMMd').format(widget.dateTime)}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' during ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.dateTime.weekday == 1
                                    ? 'Monday:\n'
                                    : widget.dateTime.weekday == 2
                                        ? 'Tuesday:\n'
                                        : widget.dateTime.weekday == 3
                                            ? 'Wednesday:\n'
                                            : widget.dateTime.weekday == 4
                                                ? 'Thursday:\n'
                                                : widget.dateTime.weekday == 5
                                                    ? 'Friday:\n'
                                                    : widget.dateTime.weekday == 6
                                                        ? 'Saturday:\n'
                                                        : 'Sunday:\n',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              if (widget.schedule != null && widget
                                      .schedule[widget.dateTime.weekday == 1
                                          ? 'Monday'
                                          : widget.dateTime.weekday == 2
                                              ? 'Tuesday'
                                              : widget.dateTime.weekday == 3
                                                  ? 'Wednesday'
                                                  : widget.dateTime.weekday == 4
                                                      ? 'Thursday'
                                                      : widget.dateTime.weekday == 5
                                                          ? 'Friday'
                                                          : widget.dateTime.weekday == 6
                                                              ? 'Saturday'
                                                              : 'Sunday']
                                      .length !=
                                  0)
                                for (int i = 0;
                                    i <
                                        widget
                                            .schedule[widget.dateTime.weekday == 1
                                                ? 'Monday'
                                                : widget.dateTime.weekday == 2
                                                    ? 'Tuesday'
                                                    : widget.dateTime.weekday == 3
                                                        ? 'Wednesday'
                                                        : widget.dateTime.weekday == 4
                                                            ? 'Thursday'
                                                            : widget.dateTime.weekday == 5
                                                                ? 'Friday'
                                                                : widget.dateTime.weekday == 6
                                                                    ? 'Saturday'
                                                                    : 'Sunday']
                                            .length;
                                    i = i + 2)
                                  TextSpan(
                                    text:
                                        ' ${widget.schedule[widget.dateTime.weekday == 1 ? 'Monday' : widget.dateTime.weekday == 2 ? 'Tuesday' : widget.dateTime.weekday == 3 ? 'Wednesday' : widget.dateTime.weekday == 4 ? 'Thursday' : widget.dateTime.weekday == 5 ? 'Friday' : widget.dateTime.weekday == 6 ? 'Saturday' : 'Sunday'][i].format(context)} to ${widget.schedule[widget.dateTime.weekday == 1 ? 'Monday' : widget.dateTime.weekday == 2 ? 'Tuesday' : widget.dateTime.weekday == 3 ? 'Wednesday' : widget.dateTime.weekday == 4 ? 'Thursday' : widget.dateTime.weekday == 5 ? 'Friday' : widget.dateTime.weekday == 6 ? 'Saturday' : 'Sunday'][i + 1].format(context)}\n',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
                              else
                                TextSpan(
                                  text: 'The Entire Day!',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                )
                            ],
                          ),
                        ),
                        SizedBox(height: 5)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:phase1/components/maps_sheet.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/pages/volunteer/donation_creation_page.dart';

import 'package:url_launcher/url_launcher.dart'; // For website links
import 'package:flutter/gestures.dart';

class OrganizationProfilePage extends StatefulWidget {
  final Organization organization;

  OrganizationProfilePage(this.organization);

  @override
  _OrganizationProfilePageState createState() => _OrganizationProfilePageState();
}

class _OrganizationProfilePageState extends State<OrganizationProfilePage> {
  bool loading = true;
  bool noRequests = true;
  TapGestureRecognizer _tapGestureRecognizer;

  _OrganizationProfilePageState();

  @override
  void initState() {
    DocumentReference organizationReference = db.collection('organizations').document(widget.organization.id);
    organizationReference.collection('requests').getDocuments().then((documents) {
      widget.organization.requestedItems.clear();
      for (DocumentSnapshot document in documents.documents) {
        if (widget.organization.itemCategories.contains(document['category'])) {
          if (widget.organization.requestedItems[document['category']] == null) widget.organization.requestedItems[document['category']] = [];
          setState(() {
            if (document['amount'] > 0) noRequests = false;
            widget.organization.requestedItems[document['category']].add(
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
                            : Colors.red,
              ),
            );
          });
        }
      }
      MapLauncher.installedMaps.then((value) => availableMaps = value);
      coords = Coords(widget.organization.location.latitude, widget.organization.location.longitude);
      title = widget.organization.address;
      setState(() {
        loading = false;
      });
    });
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = _handleTap;
  }

  @override
  void dispose() { // For the tap gesture recognizer
    _tapGestureRecognizer?.dispose();
    super.dispose();
  }
  void _handleTap() {
    String websiteURL = '';
    if (widget.organization.website.startsWith(RegExp('https{0, 1}://'))) {
      websiteURL = widget.organization.website;
    } else {
      websiteURL = "https://" + widget.organization.website;
    }
    launch(websiteURL);
    print('On Tap method called');
  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      color: Colors.white,
//      Color(0xFFF5F5F5),
      title: '',
      helpText: 'This is an organization profile page. Here, you can see information about this organization and its requests. '
          'To sign up for a donation, press the Make a Donation button!',
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
//                Color(0xFFF5F5F5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.organization.name,
                            style: mainTitleStyle,
                          ),
                          if (widget.organization.distance != null)
                            Text(
                              widget.organization.distance.toStringAsFixed(1) + ' miles away',
                              style: subTitleStyle,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GreyLine(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textDirection: TextDirection.rtl,
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
                                  padding: const EdgeInsets.only(top: 8.0, left: 20.0),
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
                                        width: 50,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.organization.description,
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (widget.organization.address != null)
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Address: ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: colorScheme.onBackground,
                                              ),
                                            ),
                                            TextSpan(
                                              text: widget.organization.address,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme.onBackground,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (widget.organization.address != null)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    if (widget.organization.website != null)
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Website: ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: colorScheme.onBackground,
                                              ),
                                            ),
                                            TextSpan(
                                              text: widget.organization.website,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue,
                                              ),
                                              recognizer: _tapGestureRecognizer
                                                // ..onTap = () {
                                                //   String websiteURL = '';
                                                //   if (widget.organization.website.startsWith(RegExp('https{0, 1}://'))) {
                                                //     websiteURL = widget.organization.website;
                                                //   } else {
                                                //     websiteURL = "https://" + widget.organization.website;
                                                //   }
                                                //   launch(websiteURL);
                                                // }
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (widget.organization.website != null)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    if (widget.organization.donationLink != null) // Donation Link
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Donation Link: ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: colorScheme.onBackground,
                                              ),
                                            ),
                                            TextSpan(
                                              text: widget.organization.donationLink,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue,
                                              ),
                                              recognizer: _tapGestureRecognizer
                                                // ..onTap = () {
                                                //   String donationURL = '';
                                                //   if (widget.organization.donationLink.startsWith(RegExp('https{0, 1}://'))) {
                                                //     donationURL = widget.organization.donationLink;
                                                //   } else {
                                                //     donationURL = "https://" + widget.organization.website;
                                                //   }
                                                //   launch(donationURL);
                                                // }
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (widget.organization.donationLink != null)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    if (widget.organization.number != null)
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Phone Number: ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: colorScheme.onBackground,
                                              ),
                                            ),
                                            TextSpan(
                                              text: widget.organization.number,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme.onBackground,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (widget.organization.number != null)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    if (widget.organization.email != null)
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Email: ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: colorScheme.onBackground,
                                              ),
                                            ),
                                            TextSpan(
                                              text: widget.organization.email,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme.onBackground,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SmallGreyLine(),
                    if (widget.organization.itemCategories != null)
                      if (widget.organization.itemCategories.length != 0)
                        Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
                                child: widget.organization.requestedItems.isEmpty
                                    ? Container()
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Requested Items',
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
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: purpleAccent,
                                              borderRadius: BorderRadius.circular(21),
                                            ),
                                          ),
                                          Column(
                                            children: widget.organization.itemCategories.map((String category) {
                                              List<Item> items = widget.organization.requestedItems[category];
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  SizedBox(height: 10.0),
                                                  Text(
                                                    category,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 23.0,
                                                    ),
                                                  ),
                                                  ...items.map(
                                                    (item) => item.amount != 0
                                                        ? Container(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                              child: Row(
                                                                children: [
                                                                  Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          '${item.name} - ${item.amount} ${item.unit ?? ''}'.trim(),
                                                                          style: TextStyle(
                                                                            fontSize: 17.0,
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                        if (item.specificDescription != null)
                                                                          Text(
                                                                            item.specificDescription,
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
                                                                            color: item.urgencyColor, borderRadius: BorderRadius.circular(40)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ),
                                                  SmallGreyLine()
                                                ],
                                              );
                                            }).toList(),
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                    SizedBox(height: 10),
                    if (!noRequests)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DonationCreationPage(organization: widget.organization),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: purpleAccent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                              child: Text(
                                'Make a Donation!',
                                style: TextStyle(color: colorScheme.onSecondary, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}

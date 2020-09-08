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

class OrganizationPreviewPage extends StatefulWidget {
  final Organization organization;

  OrganizationPreviewPage(this.organization);

  @override
  _OrganizationPreviewPageState createState() => _OrganizationPreviewPageState();
}

class _OrganizationPreviewPageState extends State<OrganizationPreviewPage> {
  bool loading = true;

  @override
  void initState() {
    DocumentReference organizationReference = db.collection('organizations').document(widget.organization.id);
    organizationReference.collection('requests').getDocuments().then((documents) {
      widget.organization.requestedItems.clear();
      for (DocumentSnapshot document in documents.documents) {
        if (widget.organization.itemCategories.contains(document['category'])) {
          if (widget.organization.requestedItems[document['category']] == null) widget.organization.requestedItems[document['category']] = [];
          setState(() {
            widget.organization.requestedItems[document['category']]
                .add(Item(name: document['name'], amount: document['amount'], category: document['category']));
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
  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: '',
      helpText: 'This page shows your organization profile as it will be seen by volunteers. ',
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                color: Color(0xFFF5F5F5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.organization.name,
                        style: mainTitleStyle,
                      ),
                      Text(
                        'X miles away',
                        style: subTitleStyle,
                      ),
                      SizedBox(height: 20),
                      Card(
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
                                        "assets/random_svgs/googlemaps.svg",
                                        height: 28,
                                      )),
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
                                              )
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
                                                  color: colorScheme.onBackground,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      if (widget.organization.website != null)
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
                      SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
                              child: Column(
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
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: purpleAccent,
                                      borderRadius: BorderRadius.circular(21),
                                    ),
                                  ),
                                  Column(
                                    children: widget.organization.requestedItems
                                        .map(
                                          (String category, List<Item> items) => MapEntry(
                                            category,
                                            Column(
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
                                                ...items
                                                    .map(
                                                      (item) => Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
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
                                                      ),
                                                    )
                                                    .toList(),
                                              ],
                                            ),
                                          ),
                                        )
                                        .values
                                        .toList(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

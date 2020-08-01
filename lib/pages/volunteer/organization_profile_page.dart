import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/alerts.dart';
import 'package:phase1/components/standard_layout.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';
import 'package:phase1/models/organization.dart';
import 'package:phase1/pages/volunteer/donation_creation_page.dart';

class OrganizationProfilePage extends StatefulWidget {
  final Organization organization;

  OrganizationProfilePage(this.organization);

  @override
  _OrganizationProfilePageState createState() => _OrganizationProfilePageState();
}

class _OrganizationProfilePageState extends State<OrganizationProfilePage> {
  bool loading = true;

  @override
  void initState() {
    DocumentReference organizationReference = db.collection('organizations').document(widget.organization.id);
    organizationReference.get().then((organizationSnapshot) {
      widget.organization.address = organizationSnapshot['address'];
      widget.organization.website = organizationSnapshot['website'];
      widget.organization.number = organizationSnapshot['number'];
      widget.organization.email = organizationSnapshot['email'];
      for (String category in organizationSnapshot['itemCategories']) {
        widget.organization.requestedItems[category] = List<Item>();
      }

      organizationReference.collection('requests').getDocuments().then((documents) {
        for (DocumentSnapshot document in documents.documents) {
          widget.organization.requestedItems[document['category']].add(Item(name: document['name'], amount: document['amount'], category: document['category']));
        }
        setState(() {
          loading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      title: '',
      helpText: 'If u don\'t know how to use this app u stupid lmao',
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
                        widget.organization.distance.toStringAsFixed(1) + ' miles away',
                        style: subTitleStyle,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: elevatedBoxStyle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'About This Shelter',
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
                                    decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
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
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'Address: ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: colorScheme.onBackground,
                                            )),
                                        TextSpan(
                                            text: widget.organization.address,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme.onBackground,
                                            ))
                                      ]),
                                    ),
                                  if (widget.organization.address != null)
                                    SizedBox(
                                      height: 10,
                                    ),
                                  if (widget.organization.website != null)
                                    RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'Website: ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: colorScheme.onBackground,
                                            )),
                                        TextSpan(
                                            text: widget.organization.website,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme.onBackground,
                                            ))
                                      ]),
                                    ),
                                  if (widget.organization.website != null)
                                    SizedBox(
                                      height: 10,
                                    ),
                                  if (widget.organization.number != null)
                                    RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'Phone Number: ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: colorScheme.onBackground,
                                            )),
                                        TextSpan(
                                            text: widget.organization.number,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme.onBackground,
                                            ))
                                      ]),
                                    ),
                                  if (widget.organization.number != null)
                                    SizedBox(
                                      height: 10,
                                    ),
                                  if (widget.organization.email != null)
                                    RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'Email: ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: colorScheme.onBackground,
                                            )),
                                        TextSpan(
                                            text: widget.organization.email,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme.onBackground,
                                            ))
                                      ]),
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          Container(
                            decoration: elevatedBoxStyle,
                            width: MediaQuery.of(context).size.width,
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
                                    decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                                  ),
                                  Column(
                                    children: widget.organization.requestedItems
                                        .map((String category, List<Item> items) => MapEntry(
                                            category,
                                            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                              SizedBox(height: 10.0),
                                              Text(
                                                category,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                              ...items
                                                  .map(
                                                    (item) => Padding(
                                                      padding: const EdgeInsets.only(top: 0.0, left: 0, right: 30),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        alignment: Alignment.centerLeft,
                                                        child: FlatButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) => NoActionAlert(title: '''Unit: Liters
Specific Description'''),
                                                            );
                                                          },
                                                          child: Text(
                                                            '${item.amount} ${item.name}',
                                                            style: TextStyle(
                                                              fontSize: 17.0,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ])))
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DonationCreationPage(organization: widget.organization)),
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
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

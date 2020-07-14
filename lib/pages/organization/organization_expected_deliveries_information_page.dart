import 'package:flutter/material.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';

class OrganizationExpectedDeliveryInformationPage extends StatefulWidget {
  final String itemName, dateRequested, dateExpected, donorName, donorEmail;
  final int itemQuantity;

  OrganizationExpectedDeliveryInformationPage(
      {@required this.itemName, @required this.itemQuantity, @required this.dateRequested, @required this.dateExpected, @required this.donorName, @required this.donorEmail});

  @override
  _OrganizationExpectedDeliveryInformationPageState createState() => _OrganizationExpectedDeliveryInformationPageState( // TODO: might need to add documentId parameter
        itemName: itemName,
        itemQuantity: itemQuantity,
        dateRequested: dateRequested,
        dateExpected: dateExpected,
        donorName: donorName,
        donorEmail: donorEmail,
      );
}

// donorName, donorEmail, itemName, itemQuantity, dateRequested, dateExpected

class _OrganizationExpectedDeliveryInformationPageState extends State<OrganizationExpectedDeliveryInformationPage> {
  final String itemName, dateRequested, dateExpected, donorName, donorEmail;
  final int itemQuantity;

  _OrganizationExpectedDeliveryInformationPageState(
      {@required this.itemName, @required this.itemQuantity, @required this.dateRequested, @required this.dateExpected, @required this.donorName, @required this.donorEmail});

  @override
  Widget build(BuildContext context) { // TODO: clean, clean, clean, clean, clean, and clean again
    return StandardLayout(
      title: "Delivery Information",
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width * 0.9, // TODO: figure out width problem
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Request",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        //THIS IS THE LINE
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Item: itemQuantity itemName",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Date Requested: dateRequested",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Date Expected: dateExpected",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width * 0.9, // TODO: figure out width problem
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Donor",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        //THIS IS THE LINE
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Donor Name: donorName",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Donor Email: donorEmail",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[], // TODO: buttons
          ),
        ],
      ),
    );
  }
}

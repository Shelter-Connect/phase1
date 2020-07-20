import 'package:flutter/material.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';
import 'organization_delivery_confirmation_page.dart';


class OrganizationExpectedDeliveryInformationPage extends StatefulWidget {
  final String dateRequested, dateExpected, donorName, donorEmail;
  final List itemQuantity;
  final List itemName;

  OrganizationExpectedDeliveryInformationPage(
      {@required this.itemName, @required this.itemQuantity, @required this.dateRequested, @required this.dateExpected, @required this.donorName, @required this.donorEmail});

  @override
  _OrganizationExpectedDeliveryInformationPageState createState() => _OrganizationExpectedDeliveryInformationPageState(
    // TODO: add documentId parameter
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
  final String dateRequested, dateExpected, donorName, donorEmail;
  final List itemQuantity;
  final List itemName;

  _OrganizationExpectedDeliveryInformationPageState({this.itemName, this.itemQuantity, this.dateRequested, this.dateExpected, this.donorName, this.donorEmail});


  @override
  Widget build(BuildContext context) {
    // TODO: clean, clean, clean, clean, clean, and clean again
    return StandardLayout(
      title: "Delivery Information",
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Items to be Delivered',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  ...itemName.map((string) => Text(string, style: TextStyle(fontSize: 20))).toList(),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  ...itemQuantity.map((int) => Text('$int', style: TextStyle(fontSize: 20))).toList(),
                                ],
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Expected Date: $dateExpected",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Date Requested: $dateRequested",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Name: $donorName",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Email: $donorEmail",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21.0)),
                  color: secondaryTertiary,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrganizationExpectedDeliveryConfirmationPage(
                            itemName: itemName,
                            itemQuantity: itemQuantity,
                            dateRequested: dateRequested,
                            dateExpected: dateExpected,
                            donorName: donorName,
                            donorEmail: donorEmail,
                          ),

                    ));
                  },
                  child: Text('Specify Items', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

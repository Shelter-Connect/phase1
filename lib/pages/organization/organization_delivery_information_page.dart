import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';
import 'organization_delivery_confirmation_page.dart';


class OrganizationExpectedDeliveryInformationPage extends StatefulWidget {
  final String dateRequested, dateExpected, donorName, donorEmail, deliveryId;
  final List itemQuantity;
  final List itemName;

  OrganizationExpectedDeliveryInformationPage(
      {@required this.itemName, @required this.itemQuantity, @required this.dateRequested, @required this.dateExpected, @required this.donorName, @required this.donorEmail, this.deliveryId});

  @override
  _OrganizationExpectedDeliveryInformationPageState createState() => _OrganizationExpectedDeliveryInformationPageState(
    // TODO: add documentId parameter
  );
}

// donorName, donorEmail, itemName, itemQuantity, dateRequested, dateExpected

class _OrganizationExpectedDeliveryInformationPageState extends State<OrganizationExpectedDeliveryInformationPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: clean, clean, clean, clean, clean, and clean again
    return StandardLayout(
      title: "Delivery Information",
      helpText: 'Click on the Specify Items Button to specify the number of items the volunteer donated!',
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
                            fontWeight: FontWeight.w600
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ...widget.itemName.map((string) => Text(string, style: TextStyle(fontSize: 20))).toList(),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  ...widget.itemQuantity.map((int) => Text('$int', style: TextStyle(fontSize: 20))).toList(),
                                ],
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Expected Date: ${widget.dateExpected}",
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
                            "Date Requested: ${widget.dateRequested}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Name: ${widget.donorName}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Email: ${widget.donorEmail}",
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
                            itemName: widget.itemName,
                            itemQuantity: widget.itemQuantity,
                            dateRequested: widget.dateRequested,
                            dateExpected: widget.dateExpected,
                            donorName: widget.donorName,
                            donorEmail: widget.donorEmail,
                          ),

                    ));
                  },
                  child: Text('Confirm Delivery', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


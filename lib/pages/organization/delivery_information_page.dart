import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/standard_layout.dart';
import '../../constants.dart';
import 'delivery_confirmation_page.dart';

class DeliveryInformationPage extends StatefulWidget {
  final String dateRequested, dateExpected, donorName, donorEmail, deliveryId;
  final List itemQuantity;
  final List itemName;

  DeliveryInformationPage(
      {@required this.itemName,
      @required this.itemQuantity,
      @required this.dateRequested,
      @required this.dateExpected,
      @required this.donorName,
      @required this.donorEmail,
      this.deliveryId});

  @override
  _DeliveryInformationPageState createState() => _DeliveryInformationPageState(
      // TODO: add documentId parameter
      );
}

// donorName, donorEmail, itemName, itemQuantity, dateRequested, dateExpected

class _DeliveryInformationPageState extends State<DeliveryInformationPage> {
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: elevatedBoxStyle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        'Items to be Delivered',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ...widget.itemName.map((string) => Text(string, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))).toList(),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  ...widget.itemQuantity.map((int) => Text('$int', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))).toList(),
                                  SizedBox(height: 10),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        //THIS IS THE LINE
                        height: 3,
                        decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Expected Date: ${widget.dateExpected}",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400
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
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Name: ${widget.donorName}",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Donor Email: ${widget.donorEmail}",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
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
                height: 40,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  color: purpleAccent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmDeliveryPage(
                            itemName: widget.itemName,
                            itemQuantity: widget.itemQuantity,
                            dateRequested: widget.dateRequested,
                            dateExpected: widget.dateExpected,
                            donorName: widget.donorName,
                            donorEmail: widget.donorEmail,
                          ),
                        ));
                  },
                  child: Text('Confirm Delivery', style: TextStyle(fontSize: 20, color: colorScheme.onSecondary)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

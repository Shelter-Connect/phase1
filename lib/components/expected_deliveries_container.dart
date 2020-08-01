import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:phase1/pages/organization/delivery_information_page.dart';

class ExpectedDeliveryContainer extends StatelessWidget {
  final String dateRequested, dateExpected, donorName, donorEmail;
  final List itemName, itemQuantity;
  final String deliveryId;
  final String category;

  ExpectedDeliveryContainer(
      {this.itemName, this.itemQuantity, this.dateRequested, this.dateExpected, this.donorName, this.donorEmail, this.deliveryId, this.category});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeliveryInformationPage(
              itemName: itemName,
              itemQuantity: itemQuantity,
              dateRequested: dateRequested,
              dateExpected: dateExpected,
              donorName: donorName,
              donorEmail: donorEmail,
              deliveryId: deliveryId,
            ),
          ),
        );
      },
      child: Container(
        decoration: elevatedBoxStyle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$donorName $dateExpected' ?? '$category',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Icon(Icons.keyboard_arrow_right),
                  ],
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ...itemQuantity
                            .map((int) => Text('$int',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                )))
                            .toList()
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ...itemName
                            .map((string) => Text(string,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400
                                )))
                            .toList()
                      ],
                    ),
                    SizedBox(height: 5)
                  ],
                ),
                //ADD MORE WIDGETS HERE
              ],
            ),
          ),
        ),
      ),
    );
  }
}

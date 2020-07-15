import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import '../pages/organization/organization_expected_deliveries_information_page.dart';

class ExpectedDeliveryContainer extends StatelessWidget {
  final String dateRequested, dateExpected, donorName, donorEmail;
  final List itemQuantity, itemName;

  ExpectedDeliveryContainer({ this.itemName,  this.itemQuantity,  this.dateRequested, this.dateExpected,  this.donorName,  this.donorEmail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrganizationExpectedDeliveryInformationPage(
                itemName: itemName,
                itemQuantity: itemQuantity,
                dateRequested: dateRequested,
                dateExpected: dateExpected,
                donorName: donorName,
                donorEmail: donorEmail,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$donorName',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '$dateExpected',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('$itemName',
                            style: TextStyle(
                              fontSize: 17,
                            ),),

                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('$itemQuantity',
                        style: TextStyle(
                        fontSize: 17,
                      ),),
                        ],
                      )
                    ],
                  ),
                  //ADD MORE WIDGETS HERE
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import '../pages/organization/organization_expected_deliveries_information_page.dart';

class ExpectedDeliveryContainer extends StatelessWidget {
  final String itemName, dateRequested, dateExpected, donorName, donorEmail;
  final int itemQuantity;

  ExpectedDeliveryContainer({@required this.itemName, @required this.itemQuantity, @required this.dateRequested, @required this.dateExpected, @required this.donorName, @required this.donorEmail});

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
        child: Stack( // TODO: make it look nicer
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            Material(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Color(0xffA1BAFF),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Text(
                  "$itemQuantity $itemName",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, color: colorScheme.onSecondary, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Material(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width * 5 / 8,
                height: 100,
                color: Color(0xff8BAAFF),
                child: Text(
                  '''Donor: $donorName
Expected Date: $dateExpected''',
                  style: TextStyle(fontSize: 20, color: colorScheme.onSecondary, fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

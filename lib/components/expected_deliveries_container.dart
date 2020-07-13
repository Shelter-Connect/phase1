import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

class ExpectedDeliveryContainer extends StatelessWidget {
  final String Item, Donor, ExpectedDate;

  ExpectedDeliveryContainer({this.Item, this.Donor, this.ExpectedDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
      child: Stack(alignment: AlignmentDirectional.centerEnd, children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          color: colorScheme.surface,
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Text(
            Item,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20, color: colorScheme.onSecondary, fontWeight: FontWeight.w400),
          ),
        ),
        Material(
          elevation: 5,
          child: Container(
              padding: EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 3 / 4,
              height: 100,
              color: colorScheme.surface,
              child: Text(
                '''Donor: $Donor
Expected Date: $ExpectedDate''',
                style: TextStyle(fontSize: 20, color: colorScheme.onSecondary, fontWeight: FontWeight.w400),
              )),
        )
      ]),
    );

  }
}

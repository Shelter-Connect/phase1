import 'package:flutter/material.dart';

class ExpectedDeliveryContainer extends StatelessWidget {
  final String Item, Donor, ExpectedDate;


ExpectedDeliveryContainer({this.Item, this.Donor, this.ExpectedDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              color: Color(0xffA1BAFF),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Text(
                Item,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w400 ),
              ),
            ),
            Material(
              elevation: 5,
              child: Container(
                  padding: EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width * 3/4,
                height: 100,
                color: Color(0xff8BAAFF),
                child: Text(
                  '''Donor: $Donor
Expected Date: $ExpectedDate''',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                )

              ),
            )
      ]),
    );

  }
}

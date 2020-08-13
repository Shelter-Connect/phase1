import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

import 'increment.dart';

class DonatePageItemSelection extends StatelessWidget {
  final String boxTitle;

  DonatePageItemSelection({this.boxTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Text(
                  boxTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
            ),
            SizedBox(
              height: 10,
            ),
            ItemIncrementWithText(itemName: 'Toilet paper'),
            SizedBox(height: 10),
            ItemIncrementWithText(itemName: 'Pillow'),
            SizedBox(height: 10),
            ItemIncrementWithText(itemName: 'Shoes'),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

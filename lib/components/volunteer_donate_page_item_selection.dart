import 'package:flutter/material.dart';

import 'package:phase1/constants.dart';
import 'package:phase1/models/item.dart';

import 'item_increment.dart';

class DonatePageItemSelection extends StatefulWidget {
  final String category;
  final List<Item> items;

  DonatePageItemSelection({this.category, this.items});

  @override
  _DonatePageItemSelectionState createState() => _DonatePageItemSelectionState();
}

class _DonatePageItemSelectionState extends State<DonatePageItemSelection> {
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
                  widget.category,
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
            ...widget.items.asMap().map((index, item) => MapEntry(index, Column(
              children: [
                ItemIncrementWithText(
                  itemName: item.name,
                  maxQuantity: item.amount,
                  onChanged: (val) {

                  },
                ),
                SizedBox(height: 10.0),
              ],
            ))).values.toList(),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

import '../../components/expected_deliveries_container.dart';
import '../navigation_tab.dart';

class ExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _ExpectedDeliveriesPageState createState() => _ExpectedDeliveriesPageState();

  @override
  String get helpDescription =>
      '''   This is the Organization Expected Deliveries Page! Here you can seee all the items that the volunteers have confirmed to deliver to your organization! 
  Click on each delivery to see more information regarding the arrival time, donor contact information, and much more!''';

  @override
  IconData get icon => Icons.access_time;

  @override
  String get title => 'Expected Deliveries';
}

class _ExpectedDeliveriesPageState extends State<ExpectedDeliveriesPage> {
  String dropdownValue = 'Sort by';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Expected Deliveries',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
              ),
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        color: colorScheme.onSecondary,
                      ),
                      width: 100,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.keyboard_arrow_down, color: purpleAccent),
                        iconSize: 20,
                        elevation: 0,
                        underline: Container(),
                        style: TextStyle(
                          color: purpleAccent,
                          fontSize: 17,
                        ),
                        onChanged: (String newValue) {
                          setState(
                            () {
                              dropdownValue = newValue;
                            },
                          );
                        },
                        items: <String>['Sort by', 'Hygiene', 'Clothing', 'Food', 'Warmth'].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        color: colorScheme.onSecondary,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          //TODO: Make Editing Feature
                        },
                        child: Row(
                          children: <Widget>[
                            Text('Edit', style: TextStyle(color: purpleAccent, fontSize: 17, fontWeight: FontWeight.normal)),
                            Spacer(),
                            Icon(
                              Icons.edit,
                              color: purpleAccent,
                              size: 20,
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
            ExpectedDeliveryContainer(
              // TODO: for firebase, need to query all information for these containers
              itemName: <String>['Toothbrushes', 'Shirts', 'Ham', 'Blankets', 'fdsakl'],
              itemQuantity: <int>[9, 10, 100, 59, 32],
              dateRequested: "dateRequested",
              category: 'hygiene',
              donorEmail: "eric@gmail.com",
            ),
            ExpectedDeliveryContainer(
              itemName: <String>['Toothpaste', 'Pants', 'Socks', 'Sleeping Bags'],
              itemQuantity: <int>[66, 57, 48, 93],
              dateRequested: "6/9",
              category: 'hygiene',
              donorEmail: "donorEmail",
            ),
            ExpectedDeliveryContainer(
              itemName: <String>['Floss', 'Belts', 'Ham', 'Caps'],
              itemQuantity: <int>[
                16,
                27,
                38,
                49,
              ],
              dateRequested: "dateRequested",
              category: 'hygiene',
              donorEmail: "donorEmail",
            ),
            ExpectedDeliveryContainer(
              itemName: <String>['Floss', 'Belts', 'Ham', 'Caps'],
              itemQuantity: <int>[
                5,
                7,
                8,
                9,
              ],
              dateRequested: "dateRequested",
              category: 'hygiene',
              donorEmail: "donorEmail",
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

import '../../components/expected_deliveries_container.dart';
import '../navigation_tab.dart';

class ExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _ExpectedDeliveriesPageState createState() => _ExpectedDeliveriesPageState();

  @override
  String get helpDescription => '''   This is the Organization Expected Deliveries Page! Here you can seee all the items that the volunteers have confirmed to deliver to your organization! 
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Expected Deliveries',
              style: mainTitleStyle,
            ),
            SizedBox(height: 20),
            ExpectedDeliveryContainer(
              // TODO: for firebase, need to query all information for these containers
              itemName: <String>['Toothbrushes', 'Shirts', 'Ham', 'Blankets', 'fdsakl'],
              itemQuantity: <int>[9, 10, 100, 59, 32],
              dateRequested: "dateRequested",
              category: 'hygiene',
              donorEmail: "eric@gmail.com",
            ),
            SizedBox(height: 20),
            ExpectedDeliveryContainer(
              itemName: <String>['Toothpaste', 'Pants', 'Socks', 'Sleeping Bags'],
              itemQuantity: <int>[66, 57, 48, 93],
              dateRequested: "6/9",
              category: 'hygiene',
              donorEmail: "donorEmail",
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

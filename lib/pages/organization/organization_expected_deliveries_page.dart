import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

import '../../components/expected_deliveries_container.dart';
import '../navigation_tab.dart';

class OrganizationExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationExpectedDeliveriesPageState createState() => _OrganizationExpectedDeliveriesPageState();

  @override
  String get helpDescription => '';

  @override
  IconData get icon => Icons.access_time;

  @override
  String get title => 'Expected Deliveries';
}

class _OrganizationExpectedDeliveriesPageState extends State<OrganizationExpectedDeliveriesPage> {
  String dropdownValue = 'Sort by';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down, color: purpleAccent),
                    iconSize: 15,
                    elevation: 0,
                    style: TextStyle(
                      color: purpleAccent,
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
                        Text('Edit', style: TextStyle(color: purpleAccent)),
                        Spacer(),
                        Icon(Icons.edit, color: purpleAccent),
                      ],
                    ),
                  )),
            )
          ],
        ),
        ExpectedDeliveryContainer( // TODO: for firebase, need to query all information for these containers
          itemName: "Beans",
          itemQuantity: 5,
          dateRequested: "dateRequested",
          dateExpected: "12/20",
          donorName: "Nathan",
          donorEmail: "donorEmail",
        ),
        ExpectedDeliveryContainer(
          itemName: "Beans",
          itemQuantity: 5,
          dateRequested: "dateRequested",
          dateExpected: "12/20",
          donorName: "Nathan",
          donorEmail: "donorEmail",
        ),
        ExpectedDeliveryContainer(
          itemName: "Beans",
          itemQuantity: 5,
          dateRequested: "dateRequested",
          dateExpected: "12/20",
          donorName: "Nathan",
          donorEmail: "donorEmail",
        ),
      ],
    );
  }
}

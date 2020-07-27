import 'package:flutter/material.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/constants.dart';

import '../navigation_tab.dart';

class CurrentRequestsPage extends StatefulWidget with NavigationTab {
  @override
  _CurrentRequestsPageState createState() => _CurrentRequestsPageState();

  @override
  String get helpDescription =>
      '''This is the Organization Current Requests Page Page! Here you can see all the items that the you have ordered but that volunteers have not committed to yet!''';

  @override
  IconData get icon => Icons.list;

  @override
  String get title => 'Current Requests';
}

class _CurrentRequestsPageState extends State<CurrentRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Current Requests',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(41),
              elevation: 5,
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
                ),
              ),
            ),
          ),
          RequestContainer(
            // TODO: for firebase, need to query all information for these containers
            itemName: <String>['Toothbrushes', 'Shirts', 'Ham', 'Blankets', 'fdsakl'],
            itemQuantity: <int>[9, 10, 100, 59, 32],
            category: 'Hygiene',
          ),
          RequestContainer(
            itemName: <String>['Toothpaste', 'Pants', 'Socks', 'Sleeping Bags'],
            itemQuantity: <int>[66, 57, 48, 93],
            category: 'Hygiene',
          ),
          RequestContainer(
            itemName: <String>['Floss', 'Belts', 'Ham', 'Caps'],
            itemQuantity: <int>[
              16,
              27,
              38,
              49,
            ],
            category: 'Hygiene',
          ),
          RequestContainer(
            itemName: <String>['Floss', 'Belts', 'Ham', 'Caps'],
            itemQuantity: <int>[
              5,
              7,
              8,
              9,
            ],
            category: 'hygiene',
          ),
        ],
      ),
    );
  }
}

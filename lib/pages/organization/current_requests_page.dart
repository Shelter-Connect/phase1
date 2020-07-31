import 'package:flutter/material.dart';
import 'package:phase1/components/requests_container.dart';
import 'package:phase1/constants.dart';

import '../navigation_tab.dart';
import 'create_request_page.dart';

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
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Current Requests',
                style: mainTitleStyle,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFDEDEDE),
                          blurRadius: 20.0,
                          spreadRadius: 0.025,
                          offset: Offset(
                            0.0,
                            0.0,
                          )),
                    ]),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.white, onPressed: () {  },
                    child: IntrinsicWidth(
                      child: Row(
                        children: <Widget>[
                          Text('Edit', style: smallButtonStyle),
                          SizedBox(width: 5.0),
                          Column(
                            children: [
                              SizedBox(height: 5.0),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: purpleAccent,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),)
              ),
              SizedBox(height: 20),
              RequestContainer(
                // TODO: for firebase, need to query all information for these containers
                itemName: <String>['Toothbrushes', 'Shirts', 'Ham', 'Blankets', 'fdsakl'],
                itemQuantity: <int>[9, 10, 100, 59, 32],
                category: 'Hygiene',
              ),
              SizedBox(height: 20),
              RequestContainer(
                itemName: <String>['Toothpaste', 'Pants', 'Socks', 'Sleeping Bags'],
                itemQuantity: <int>[66, 57, 48, 93],
                category: 'Hygiene',
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: purpleAccent,
        heroTag: 'create request',
        // Create request testing code
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRequestPage()),
          );
        },
        label: Text('New Request'),
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );

  }
}

import 'package:flutter/material.dart';

import '../navigation_tab.dart';

class OrganizationExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationExpectedDeliveriesPageState createState() => _OrganizationExpectedDeliveriesPageState();

  @override
  String get helpDescription => 'fdas';

  @override
  IconData get icon => Icons.access_time;

  @override
  String get title => 'Expected Deliveries';
}

class _OrganizationExpectedDeliveriesPageState extends State<OrganizationExpectedDeliveriesPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'boxTitle',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      //THIS IS THE LINE
                      height: 5,
                      width: 100,
                      decoration: BoxDecoration(color: Color(0xFF6576EC), borderRadius: BorderRadius.circular(21)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

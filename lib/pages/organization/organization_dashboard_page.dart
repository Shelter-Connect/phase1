import 'package:flutter/material.dart';
import 'package:phase1/components/dashboard_button.dart';
import 'package:phase1/components/dashboard_component.dart';
import 'package:phase1/components/text_button.dart';
import 'package:phase1/constants.dart';

import '../navigation_tab.dart';
import 'organization_create_request_page.dart';
import 'organization_expected_deliveries_page.dart';

class OrganizationDashboardPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationDashboardPageState createState() => _OrganizationDashboardPageState();

  @override
  String get helpDescription =>
      '''  Hello, and welcome to the Organization Dashboard! In this page, you can get a quick glimpse of deliveries that volunteers have agreed to donate, also known as "Expected Deliveries."
  Current requests allow you to view the items that have not yet been claimed by a volunteer. You may edit those requests at any time. 
  Have fun!
      ''';

  @override
  IconData get icon => Icons.home;

  @override
  String get title => 'Dashboard';
}

class _OrganizationDashboardPageState extends State<OrganizationDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
                ),
                SizedBox(height: 20),
                DashboardComponent(
                  boxTitle: '# Expected Deliveries',
                  column: Column(
                    children: <Widget>[
                      DashboardButton(
                        title: '6 blankets',
                        color: colorScheme.onSecondary,
                        onTap: () {
                          //TODO: Make new page, which is Expected Deliveries - Extended
                        },
                        icon: Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      DashboardButton(
                        title: '3 sweaters',
                        color: colorScheme.onSecondary,
                        onTap: () {
                          //TODO: Make new page, which is Expected Deliveries - Extended
                        },
                        icon: Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      DashboardButton(
                        title: '4 sweaters',
                        color: colorScheme.onSecondary,
                        onTap: () {
                          //TODO: Make new page, which is Expected Deliveries - Extended
                        },
                        icon: Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          text: 'See all',
                          onPressed: () {
                            //TODO: Make this button go to Expected Deliveries
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                DashboardComponent(
                  boxTitle: '# Current Requests',
                  height: 250,
                  column: Column(
                    children: <Widget>[
                      DashboardButton(
                        title: '5 blankets',
                        color: colorScheme.onSecondary,
                        onTap: () {
                          //TODO: Make new page, which is Expected Deliveries - Extended
                        },
                      ),
                      SizedBox(height: 5),
                      DashboardButton(
                        title: '6 beans',
                        color: colorScheme.onSecondary,
                        onTap: () {
                          //TODO: Make new page, which is Expected Deliveries - Extended
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          text: 'See all',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrganizationExpectedDeliveriesPage()),
                            );
                            //TODO: Make this button go to Expected Deliveries
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
//              Align(
//                alignment: Alignment.centerRight,
//                child: Padding(
//                  padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
//                  child: FloatingActionButton(
//                    backgroundColor: purpleAccent,
//                    heroTag: 'create request',
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => OrganizationRequestPage()),
//                      );
//                    },
//                    child: Icon(
//                      Icons.add,
//                      color: colorScheme.onSecondary,
//                    ),
//                  ),
//                ),
//              )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleAccent,
          heroTag: 'create request',
          // Create request testing code
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrganizationRequestPage()),
            );
          },
          child: Icon(
            Icons.add,
            color: colorScheme.onSecondary,
          ),
        ),
    );
  }
}

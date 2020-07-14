import 'package:flutter/cupertino.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
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
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Hero(
                tag: 'create request',
                child: Container(
                  padding: EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                    color: Color(0xff6474E1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, size: 30,),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrganizationRequestPage()),
                      );
                    }
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

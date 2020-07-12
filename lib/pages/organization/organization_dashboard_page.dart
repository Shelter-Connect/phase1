import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/dashboard_button.dart';
import 'package:phase1/components/text_button.dart';
import 'package:phase1/constants.dart';

import '../navigation_tab.dart';

class OrganizationDashboardPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationDashboardPageState createState() => _OrganizationDashboardPageState();

  @override
  String get helpDescription => 'This is a help description for the organization dashboard.';

  @override
  IconData get icon => Icons.home;

  @override
  String get title => 'Dashboard';
}

class _OrganizationDashboardPageState extends State<OrganizationDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Text('15 Expected Deliveries', style: headerStyle),
                  DashboardButton(
                    title: '6 blankets',
                    color: Colors.white,
                    onTap: () {
                      //TODO: Make new page, which is Expected Deliveries - Extended
                    },
                  ),
                  DashboardButton(
                    title: '3 sweaters',
                    color: Colors.white,
                    onTap: () {
                      //TODO: Make new page, which is Expected Deliveries - Extended
                    },
                  ),
                  DashboardButton(
                    title: '4 sweaters',
                    color: Colors.white,
                    onTap: () {
                      //TODO: Make new page, which is Expected Deliveries - Extended
                    },
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
            SizedBox(height: 39),
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Text('60 Current Deliveries', style: headerStyle),
                  DashboardButton(
                    title: '6 beans',
                    color: Colors.white,
                    onTap: () {
                      //TODO: Make new page, which is Expected Deliveries - Extended
                    },
                  ),
                  DashboardButton(
                    title: '5 Blankets',
                    color: Colors.white,
                    onTap: () {
                      //TODO: Make new page, which is Expected Deliveries - Extended
                    },
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
          ],
        ),
      ),
    );
  }
}

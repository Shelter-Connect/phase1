import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phase1/components/dashboard_button.dart';
import 'package:phase1/components/dashboard_components.dart';
import 'package:phase1/components/text_button.dart';

import '../navigation_tab.dart';
import 'organization_expected_deliveries_page.dart';

class OrganizationDashboardPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationDashboardPageState createState() => _OrganizationDashboardPageState();

  @override
  String get helpDescription => '''  Hello, and welcome to the Organization Dashboard! In this page, you can get a quick glimpse of deliveries that volunteers have agreed to donate, also known as "Expected Deliveries."
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
          DashboardComp(
            boxTitle: '# Expected Deliveries',
            column: Column(
              children: <Widget>[
                DashboardButton(
                  title: '6 blankets',
                  color: Colors.white,
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
                  color: Colors.white,
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
                  color: Colors.white,
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
          DashboardComp(
            boxTitle: '# Current Requests',
            height: 250,
            column: Column(
              children: <Widget>[
                DashboardButton(
                  title: '5 blankets',
                  color: Colors.white,
                  onTap: () {
                    //TODO: Make new page, which is Expected Deliveries - Extended
                  },
                ),
                DashboardButton(
                  title: '6 beans',
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
              child: FloatingActionButton(
                backgroundColor: Color(0xff6474E1),
                focusColor: Color(0xffffffff),
                elevation: 5,
                shape: CircleBorder(),
                onPressed: (){

                  //TODO: Go to Create Request Page
                },
                child:
                Icon(
                Icons.add,
                size: 30,
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

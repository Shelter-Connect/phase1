import 'package:flutter/material.dart';

import '../../components/dashboard_component.dart';
import '../../constants.dart';
import '../navigation_tab.dart';

class OrganizationContactUsPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationContactUsPageState createState() => _OrganizationContactUsPageState();

  @override
  String get helpDescription => '';

  @override
  IconData get icon => Icons.account_circle;

  @override
  String get title => 'Contact Us';

  @override
  Color get color => Colors.lightGreenAccent;
}

class _OrganizationContactUsPageState extends State<OrganizationContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contact Us',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
          ),
          DashboardComponent(
            boxTitle: 'Shelter Connect',
            column: Column(children: <Widget>[
              Text(
                'E-mail address: shelterconnect20@gmail.com',
                style: TextStyle(fontSize: 25, color: colorScheme.onBackground),
              ),
              SizedBox(height: 30),
              Text(
                'Phone Number: 408-999-9999',
                style: TextStyle(fontSize: 25, color: colorScheme.onBackground),
              ),
              SizedBox(height: 30),
              Text(
                'Location: 960 W Hedding St, San Jose, CA 95126',
                style: TextStyle(fontSize: 25, color: colorScheme.onBackground),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

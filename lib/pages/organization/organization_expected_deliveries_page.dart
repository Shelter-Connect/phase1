import 'package:flutter/material.dart';

import '../navigation_tab.dart';

class OrganizationExpectedDeliveriesPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationExpectedDeliveriesPageState createState() => _OrganizationExpectedDeliveriesPageState();

  @override
  String get helpDescription => 'This is a help description for the organization expected deliveries page.';

  @override
  IconData get icon => Icons.access_time;

  @override
  String get title => 'Expected Deliveries';
}

class _OrganizationExpectedDeliveriesPageState extends State<OrganizationExpectedDeliveriesPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

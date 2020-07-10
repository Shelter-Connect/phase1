import 'package:flutter/material.dart';

import 'navigation_tab.dart';

class OrganizationDashboardPage extends StatefulWidget with NavigationTab {
  @override
  _OrganizationDashboardPageState createState() => _OrganizationDashboardPageState();

  @override
  String get helpDescription => 'This is a help description for the organization dashboard.';

  @override
  // TODO: implement icon
  IconData get icon => Icons.home;

  @override
  // TODO: implement title
  String get title => 'Dashboard';
}

class _OrganizationDashboardPageState extends State<OrganizationDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
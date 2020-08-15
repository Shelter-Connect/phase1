import 'package:flutter/material.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';
import '../navigation_tab.dart';

class OrganizationHome extends StatefulWidget with NavigationTab {
  @override
  _OrganizationHomeState createState() => _OrganizationHomeState();

  @override
  String get helpDescription => 'Home page boI';

  @override
  IconData get icon => Icons.home;

  @override
  String get title => 'Home';
}

class _OrganizationHomeState extends State<OrganizationHome> {
  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      Provider.of<UserPosition>(context, listen: false).position = position;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('HOME Boy');
  }
}
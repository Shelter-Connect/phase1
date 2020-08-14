import 'package:flutter/material.dart';
import 'package:phase1/models/user_position.dart';
import 'package:phase1/services/location_helper.dart';
import 'package:provider/provider.dart';
import '../navigation_tab.dart';

class VolunteerHome extends StatefulWidget with NavigationTab {
  @override
  _VolunteerHomeState createState() => _VolunteerHomeState();

  @override
  String get helpDescription => 'Home page boI';

  @override
  IconData get icon => Icons.home;

  @override
  String get title => 'Home';

  @override
  String get barTitle => 'Linkare';


}

class _VolunteerHomeState extends State<VolunteerHome> {
  @override
  void initState() {
    LocationHelper.getUserPosition().then((position) {
      Provider.of<UserPosition>(context, listen: false).position = position;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('howdy whats up');
  }
}

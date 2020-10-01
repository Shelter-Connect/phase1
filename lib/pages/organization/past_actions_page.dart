import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../navigation_tab.dart';

class PastActionsPage extends StatefulWidget with NavigationTab {
  @override
  _PastActionsPageState createState() => _PastActionsPageState();

  @override
  String get helpDescription =>
      'This is your Current Requests page. Here, you can see items that you have requested that have not volunteers have not signed up for. '
          'To see items that volunteers have committed to, check the Expected Deliveries page.';

  @override
  IconData get icon => Feather.clock;

  @override
  String get title => 'History';

  @override
  String get barTitle => 'History';
}

class _PastActionsPageState extends State<PastActionsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text('Insert Tabs of past deliveries and past requests'),
          Text('Depending on tab display those items'),
          Text('Give them chances to delete, Call back a request/delivery, add a duplicate request -- ideas'),
        ],
      ),
    );
  }
}

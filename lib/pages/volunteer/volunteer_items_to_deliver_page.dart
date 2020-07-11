import 'package:flutter/material.dart';

import '../navigation_tab.dart';


class ItemsToDeliverPage extends StatefulWidget with NavigationTab {
  @override
  _ItemsToDeliverPageState createState() => _ItemsToDeliverPageState();

  @override
  String get helpDescription => 'This is a help description for the volunteer: items to deliver page';

  @override
  IconData get icon => Icons.home;

  @override
  String get title => 'Items To Deliver';
}

class _ItemsToDeliverPageState extends State<ItemsToDeliverPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
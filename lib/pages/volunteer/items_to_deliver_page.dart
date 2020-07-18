import 'package:flutter/material.dart';
import 'package:phase1/components/volunteer_organization_item_section.dart';
import 'package:phase1/constants.dart';
import '../navigation_tab.dart';

class ItemsToDeliverPage extends StatefulWidget with NavigationTab {
  @override
  _ItemsToDeliverPageState createState() => _ItemsToDeliverPageState();

  @override
  String get helpDescription => 'This is a help description for the volunteer: items to deliver page';

  @override
  IconData get icon => Icons.local_shipping;

  @override
  String get title => 'Items To Deliver';
}

class _ItemsToDeliverPageState extends State<ItemsToDeliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Items to Deliver',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
              ),
              SizedBox(height: 20),
              OrganizationItemSection(
                organizationName: 'HomeFirst',
                organizationDistance: 5.6,
              ),
              SizedBox(height: 15),
              OrganizationItemSection(
                organizationName: 'City Team Men\'s Shelter',
                organizationDistance: 1.8,
              ),
              SizedBox(height: 15),
              OrganizationItemSection(
                organizationName: 'Loaves and Fishes',
                organizationDistance: 2.6,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



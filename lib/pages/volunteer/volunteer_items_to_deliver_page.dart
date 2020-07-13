import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

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
    return Scaffold(
      backgroundColor: Color(0xFFDAE5F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Text(
                'Items to Deliver',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: purpleAccent),
              ),
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
    );
  }
}

class OrganizationItemSection extends StatefulWidget {
  final String organizationName;
  final double organizationDistance;

  OrganizationItemSection({this.organizationName, this.organizationDistance});

  @override
  _OrganizationItemSectionState createState() => _OrganizationItemSectionState();
}

class _OrganizationItemSectionState extends State<OrganizationItemSection> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, '/items_deliver_extended');
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(
                    widget.organizationName,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('${widget.organizationDistance} + miles away'),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Blankets x4'),
              SizedBox(
                height: 5,
              ),
              Text('Bananas x15'),
              SizedBox(height: 5),
              Text('Can of Beans x8'),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
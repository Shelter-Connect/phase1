import 'package:flutter/material.dart';
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

class OrganizationItemSection extends StatelessWidget {
  final String organizationName;
  final double organizationDistance;

  OrganizationItemSection({this.organizationName, this.organizationDistance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, '/items_to_deliver_extended');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(color: colorScheme.onSecondary, borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      organizationName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        padding: EdgeInsets.all(0.0),
                        onPressed: () {
                          //TODO
                        },
                      ),
                    ),
                  ],
                ),
                Text(
                  '$organizationDistance miles',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
                ),
                SizedBox(height: 10),
                Text('Blankets x4', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 5),
                Text('Bananas x15', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 5),
                Text('Can of Beans x8', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

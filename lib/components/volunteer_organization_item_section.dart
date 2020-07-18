import 'package:flutter/material.dart';

import 'package:phase1/constants.dart';
import 'package:phase1/pages/volunteer/items_to_deliver_extended.dart';

class OrganizationItemSection extends StatelessWidget {
  final String organizationName;
  final double organizationDistance;

  OrganizationItemSection({this.organizationName, this.organizationDistance});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemsToDeliverExtended()));
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
    );
  }
}
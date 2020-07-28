import 'package:flutter/material.dart';

import '../constants.dart';

class DashboardComponent extends StatelessWidget {
  final String boxTitle, expectedDate;
  final Widget column;
  final double height;
  DashboardComponent({@required this.boxTitle, this.column, this.height, this.expectedDate});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: elevatedBoxStyle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                boxTitle,
//                  textAlign: TextAlign.spaceBetween,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                //THIS IS THE LINE
                height: 5,
                width: 75,
                decoration: BoxDecoration(color: purpleAccent, borderRadius: BorderRadius.circular(21)),
              ),
              SizedBox(height: 10),
              column,
              //ADD MORE WIDGETS HERE
            ],
          ),
        ),
      ),
    );
  }
}

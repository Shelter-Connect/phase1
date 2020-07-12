import 'package:flutter/material.dart';

import '../constants.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onTap;

  DashboardButton({@required this.title, this.color, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(25.0),
        child: ListTile(
          onTap: onTap,
          title: Text(title, style: subheaderStyle),
          trailing:  Icon(Icons.arrow_right, size: 40,),
        ),
      ),
    );
  }
}
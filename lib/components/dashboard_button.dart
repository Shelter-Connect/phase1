import 'package:flutter/material.dart';

import '../constants.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onTap;
  final Widget icon;

  DashboardButton({@required this.title, this.color, this.icon,@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(35.0),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
            onTap: onTap,
            title: Text(title, style: subHeaderStyle),
            trailing: icon
          ),
        ),
      ),
    );
  }
}
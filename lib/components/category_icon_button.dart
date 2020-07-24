import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CategoryIconButton extends StatelessWidget {
  final Function onPressed;
  final String asset, name;

  CategoryIconButton({this.onPressed, this.asset, this.name});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      onPressed: onPressed,
      child: Container(
        height: 110.0,
        width: 110.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: colorScheme.onSecondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WebsafeSvg.asset(asset, height: 55, width: 55),
            Text(name, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

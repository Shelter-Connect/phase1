import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../constants.dart';

class CategoryIconButton extends StatelessWidget {
  final Function onPressed;
  final String asset, name;

  CategoryIconButton({this.onPressed, this.asset, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Container(
          height: 105.0,
          width: 105.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: colorScheme.background,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WebsafeSvg.asset(asset, height: 55, width: 55),
              Text(name, style: TextStyle(fontSize: 15), textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryIconDisplay extends StatelessWidget {
  final String asset, name;

  CategoryIconDisplay({this.asset, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 105.0,
        width: 105.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colorScheme.background,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WebsafeSvg.asset(asset, height: 55, width: 55),
            Text(name, style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class ItemIconButton extends StatelessWidget {
  final Function onPressed;
  final String asset, name;

  ItemIconButton({this.onPressed, this.asset, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Container(
          height: 105.0,
          width: 105.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.0, color: Color(0xFFF5F5F5)),
            color: colorScheme.background,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WebsafeSvg.asset(asset, height: 55, width: 55),
              Text(name, style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

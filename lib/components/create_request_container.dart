import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:websafe_svg/websafe_svg.dart';


class CreateRequestContainer extends StatelessWidget {

  final double height, width, fontSize;
  final Function onPressed;
  final String asset, name;

  CreateRequestContainer({this.height,this.width, @required this.onPressed, @required this.asset,@required this.name, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        color: Colors.white,
      ),
      height: height ?? 125,
      width: width ?? 125,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: onPressed,
            child: WebsafeSvg.asset(asset, height: 75, width: 75),
          ),
          Text(name, style: TextStyle(fontSize: fontSize ?? 25, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

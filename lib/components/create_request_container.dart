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
    return FlatButton(
      onPressed: () {
        //TODO send to create request choose item
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 4.5,
        width: MediaQuery.of(context).size.width / 4.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: Colors.white,
        ),
//        height: height ?? 125,
//        width: width ?? 125,
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            WebsafeSvg.asset(asset, height: 55, width: 55),
            Text(name, style: TextStyle(fontSize: fontSize ?? 15, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

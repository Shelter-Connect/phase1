import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:phase1/constants.dart';

class FlushBar extends StatelessWidget {
  final String title, message;
  final Icon icon;
  final Duration duration;
  final Widget mainButton;
  final Function onTap;
  final bool isDismissible;
  final EdgeInsets margin;
  final Color leftBarIndicatorColor;
  FlushBar({this.title, this.message, this.icon, this.duration, this.mainButton, this.onTap, this.isDismissible, this.margin, this.leftBarIndicatorColor});
  @override
  Widget build(BuildContext context) {
    Flushbar(
      title: title ?? null,
      message: message ?? null,
      icon: icon ?? Icon(Icons.info_outline, color: Colors.white,),
      leftBarIndicatorColor: leftBarIndicatorColor ?? purpleAccent,
      duration: duration ?? Duration(seconds: 2),
      mainButton: mainButton,
      onTap: onTap,
      isDismissible: true,
      animationDuration: Duration(seconds: 0),
      flushbarStyle:  FlushbarStyle.GROUNDED,
    ).show(context);
  }
}

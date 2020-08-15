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
  FlushBar({this.title, this.message, this.icon, this.duration, this.mainButton, this.onTap, this.isDismissible});
  @override
  Widget build(BuildContext context) {
    Flushbar(
      title: title ?? null,
      message: message ?? null,
      icon: icon ?? Icon(Icons.info_outline),
      leftBarIndicatorColor: purpleAccent,
      duration: duration ?? Duration(seconds: 3),
      mainButton: mainButton,
      onTap: onTap,
      isDismissible: isDismissible ?? true,
    ).show(context);
  }
}

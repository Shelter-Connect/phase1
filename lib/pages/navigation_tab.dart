import 'package:flutter/material.dart';

mixin NavigationTab on StatefulWidget {
  String get title;

  String get barTitle;

  Widget get icon;

  Widget get activeIcon;

  String get helpDescription;
}

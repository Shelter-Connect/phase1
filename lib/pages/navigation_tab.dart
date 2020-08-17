import 'package:flutter/material.dart';

mixin NavigationTab on StatefulWidget {
  String get title;

  String get barTitle;

  IconData get icon;

  String get helpDescription;
}

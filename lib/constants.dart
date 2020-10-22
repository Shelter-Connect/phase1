import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

//Firebase
final FirebaseAuth auth = FirebaseAuth.instance;
final Firestore db = Firestore.instance;

//Maps
final kGoogleApiKey = "AIzaSyDtBjj6ReiOlVtylupAx-wcLe2HmsJXXFs";
List<AvailableMap> availableMaps = List();
Coords coords = Coords(0, 0);
String title = '';

//Calendars
List<Calendar> calendars;
DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();

//Styles
//Text Styles
final largeTitleStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 47.0,
);

final settingsTitle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 47.0,
  color: purpleAccent,
);

final headerStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 30.0,
);

final subHeaderStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 17.0,
);

final mainTitleStyle = TextStyle(fontWeight: FontWeight.w900, fontSize: 35, color: purpleAccent);

final appBarTitleStyle = TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: purpleAccent);

final mainTitleStyle2 = TextStyle(fontWeight: FontWeight.w800, fontSize: 28, color: Colors.black);

final subTitleStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: purpleLight);

final smallButtonStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: purpleAccent);

final elevatedBoxStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Color(0xFFDEDEDE),
      blurRadius: 8.0,
      spreadRadius: 1.5,
      offset: Offset(
        0.0,
        0.0,
      ),
    ),
  ],
);
final subElevatedBoxStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(41),
  boxShadow: [
    BoxShadow(
      color: Color(0xFFDEDEDE),
      blurRadius: 8.0,
      spreadRadius: 1.5,
      offset: Offset(
        0.0,
        0.0,
      ),
    ),
  ],
);
final sub2ElevatedBoxStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Color(0xFFDEDEDE),
      blurRadius: 2.0,
      spreadRadius: 0.6,
      offset: Offset(
        0.0,
        0.0,
      ),
    ),
  ],
);
//Colors
final colorScheme = ColorScheme(
  primary: Color(0xff42a5f5),
  //Color(0xffbbdefb),
  primaryVariant: Color(0xff8aacc8),
  secondary: Color(0xff42a5f5),
  secondaryVariant: Color(0xff0077c2),
  surface: Color(0xffacc0e6),
  background: Color(0xffffffff),
  error: Color(0xffff3053),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xfffafafa),
  onSurface: Color(0xffbbdefb),
  onBackground: Color(0xff000000),
  onError: Color(0xffbbdefb),
  brightness: Brightness.light,
);

Color purpleAccent = Color(0xFF6576EC);
Color darkPurpleAccent = Color(0xFF4652a5);
Color purpleLight = Color(0xFF919DEE);
Color blueAccent = Color(0xff187CFF);
Color whiteBackground = Color(0xFFDAE5F9);
Color secondaryTertiary = Colors.blue;
Color transparent = Colors.transparent;
Color grey = Colors.white24;
Color lightGrey = Color(0xFFCCCCCC);

//Categories
List categories = [];

class GreyLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.black12, height: 20, thickness: 3, endIndent: 0);
  }
}

class SmallGreyLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.black12, height: 20, indent: 20, thickness: 3, endIndent: 20);
  }
}

class SmallestGreyLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.black12, height: 20, indent: 30, thickness: 2, endIndent: 30);
  }
}

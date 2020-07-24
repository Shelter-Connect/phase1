import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Firebase
FirebaseAuth auth = FirebaseAuth.instance;
Firestore db = Firestore.instance;

//Google Maps
final kGoogleApiKey = "AIzaSyDtBjj6ReiOlVtylupAx-wcLe2HmsJXXFs";

// Text Styles
final titleStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 47.0,
);

final headerStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 30.0,
);

final subHeaderStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 17.0,
);

//Colors
final colorScheme = ColorScheme(
  primary: Color(0xff42a5f5), //Color(0xffbbdefb),
  primaryVariant: Color(0xff8aacc8),
  secondary: Color(0xff42a5f5),
  secondaryVariant: Color(0xff0077c2),
  surface: Color(0xffacc0e6),
  background: Color(0xffffffff),
  error: Color(0xfffe445c),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xfffafafa),
  onSurface: Color(0xffbbdefb),
  onBackground: Color(0xff000000),
  onError: Color(0xffbbdefb),
  brightness: Brightness.light,
);

Color purpleAccent = Color(0xFF6576EC);
Color blueAccent = Color(0xff187CFF);
Color whiteBackground = Color(0xFFDAE5F9);
Color secondaryTertiary = Colors.blue;
Color transparent = Colors.transparent;

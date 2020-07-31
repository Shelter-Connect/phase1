import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Firebase
FirebaseAuth auth = FirebaseAuth.instance;
Firestore db = Firestore.instance;

//Google Maps
final kGoogleApiKey = "AIzaSyDtBjj6ReiOlVtylupAx-wcLe2HmsJXXFs";

//Categories
final categories = [
  [
    'assets/hygiene_svgs/hygiene.svg',
    'Hygiene',
    {
      'Body Soap': 'assets/hygiene_svgs/body_soap.svg',
      'Nail Clipper': 'assets/hygiene_svgs/nail_clipper.svg',
      'Soap': 'assets/hygiene_svgs/soap.svg',
      'Toilet Paper': 'assets/hygiene_svgs/toilet_paper.svg',
      'Toothbrush': 'assets/hygiene_svgs/toothbrush.svg',
      'Toothpaste': 'assets/hygiene_svgs/toothpaste.svg',
    },
    'Hygiene is a very important part of a person\'s day. Staying clean is one way to brighten someone\'s day!'
  ],
  [
    'assets/clothing_svgs/clothes.svg',
    'Clothes',
    {
      'Beanie': 'assets/clothing_svgs/beanie.svg',
      'Gloves': 'assets/clothing_svgs/gloves.svg',
      'Hats': 'assets/clothing_svgs/hats.svg',
      'Socks': 'assets/clothing_svgs/socks.svg',
      'Underwear': 'assets/clothing_svgs/underwear.svg',
      'Shirts': 'assets/clothing_svgs/shirt.svg',
    },
    'Clothes protect not only your body from physical harm, but strengthen your spirits and self-confidence.'
  ],
  [
    'assets/nutrition_svgs/nutrition.svg',
    'Nutrition',
    {
      'Beans': 'assets/nutrition_svgs/beans.svg',
      'Bread': 'assets/nutrition_svgs/bread.svg',
      'Eggs': 'assets/nutrition_svgs/eggs.svg',
      'Energy bars': 'assets/nutrition_svgs/energy_bar.svg',
      'Potatoes': 'assets/nutrition_svgs/potato.svg',
      'Water': 'assets/nutrition_svgs/water.svg',
    },
    'A healthy and filling meal, at times, is worth more than a million dollars.'
  ],
  [
    'assets/covid-19_response_svg/covid_19.svg',
    'COVID-19',
    {
      'Face Shield': 'assets/covid-19_response_svg/face_shield.svg',
      'Hand Sanitizers': 'assets/covid-19_response_svg/hand_sanitizer.svg',
      'Latex Gloves': 'assets/covid-19_response_svg/latex_gloves.svg',
      'Masks': 'assets/covid-19_response_svg/mask.svg',
      'Wipes': 'assets/covid-19_response_svg/wipes.svg',
    },
    'Everyone deserves protection, especially in these trying times.'
  ],
  [
    'assets/warmth_svgs/warmth.svg',
    'Warmth',
    {
      'Blankets': 'assets/warmth_svgs/blanket.svg',
      'Sleeping Bag': 'assets/warmth_svgs/sleeping_bag.svg',
      'Sleeping Pad': 'assets/warmth_svgs/sleeping_pad.svg',
    },
    'The need for warmth has been engraved into humans since the beginning of life, and has never disappeared'
  ],
  ['assets/other_svgs/other.svg', 'Other', {}, 'For people to live even at the bare minimum, they require more than the necessities'],
];

//Styles
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
final elevatedBoxStyle = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
  BoxShadow(
      color: Color(0xFFDEDEDE),
      blurRadius: 8.0,
      spreadRadius: 1.5,
      offset: Offset(
        0.0,
        0.0,
      )),
]);
final subElevatedBoxStyle = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(41), boxShadow: [
  BoxShadow(
      color: Color(0xFFDEDEDE),
      blurRadius: 8.0,
      spreadRadius: 1.5,
      offset: Offset(
        0.0,
        0.0,
      )),
]);
final sub2ElevatedBoxStyle = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
  BoxShadow(
      color: Color(0xFFDEDEDE),
      blurRadius: 2.0,
      spreadRadius: 0.6,
      offset: Offset(
        0.0,
        0.0,
      )),
]);

//Colors
final colorScheme = ColorScheme(
  primary: Color(0xff42a5f5),
  //Color(0xffbbdefb),
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
Color purpleLight = Color(0xFF919DEE);
Color blueAccent = Color(0xff187CFF);
Color whiteBackground = Color(0xFFDAE5F9);
Color secondaryTertiary = Colors.blue;
Color transparent = Colors.transparent;
Color grey = Colors.white24;
Color lightGrey = Color(0xFFCCCCCC);

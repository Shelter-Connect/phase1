import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

//Firebase
final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;

//Maps
final kGoogleApiKey = "AIzaSyDtBjj6ReiOlVtylupAx-wcLe2HmsJXXFs";
List<AvailableMap> availableMaps = [];
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

final subTitleStyle2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: purpleAccent);

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
List categories = [
  {
    'asset': 'assets/hygiene_svgs/hygiene.svg',
    'name': 'Hygiene',
    'items': {
      'Body Soap': 'assets/hygiene_svgs/body_soap.svg',
      'Lip Balm': 'assets/hygiene_svgs/lip_balm.svg',
      'Nail Clippers': 'assets/hygiene_svgs/nail_clipper.svg',
      'Soap': 'assets/hygiene_svgs/soap.svg',
      'Toilet Paper': 'assets/hygiene_svgs/toilet_paper.svg',
      'Toothbrushes': 'assets/hygiene_svgs/toothbrush.svg',
      'Toothpaste': 'assets/hygiene_svgs/toothpaste.svg',
      'Bath Towels': 'assets/hygiene_svgs/bath_towel.svg',
      'Shaving Cream': 'assets/hygiene_svgs/shaving_cream.svg',
      'Razors': 'assets/hygiene_svgs/razor.svg',
      'Deodorant': 'assets/hygiene_svgs/deodorant.svg',
      'Shampoo': 'assets/hygiene_svgs/shampoo.svg',
      'Diapers': 'assets/hygiene_svgs/diaper.svg',
      'Laundry Detergent': 'assets/hygiene_svgs/laundry_detergent.svg',
    },
    'description': ''
//        'Hygiene is a very important part of a person\'s day. Staying clean is one way to brighten someone\'s day!'
  },
  {
    'asset': 'assets/clothing_svgs/clothes.svg',
    'name': 'Clothes',
    'items': {
      'Beanies': 'assets/clothing_svgs/beanie.svg',
      'Gloves': 'assets/clothing_svgs/gloves.svg',
      'Hats': 'assets/clothing_svgs/hats.svg',
      'Socks': 'assets/clothing_svgs/socks.svg',
      'Men\'s Underwear': 'assets/clothing_svgs/underwear.svg',
      'Women\'s Underwear': 'assets/clothing_svgs/women_underwear.svg',
      'T-Shirts': 'assets/clothing_svgs/shirt.svg',
      'Waist Pants': 'assets/clothing_svgs/elastic_waist_pants.svg',
    },
    'description': ''
//    'Clothes protect not only your body from physical harm, but strengthen your spirits and self-confidence.'
  },
  {
    'asset': 'assets/nutrition_svgs/nutrition.svg',
    'name': 'Nutrition',
    'items': {
      'Canned Beans': 'assets/nutrition_svgs/beans.svg',
      'Tomato Sauce': 'assets/nutrition_svgs/tomatosauce.svg',
      'Rice': 'assets/nutrition_svgs/rice.svg',
      'Pasta': 'assets/nutrition_svgs/pasta.svg',
      'Ground Meats': 'assets/nutrition_svgs/groundbeef.svg',
      'Chicken': 'assets/nutrition_svgs/chicken.svg',
      'Tuna': 'assets/nutrition_svgs/tuna.svg',
      'Vegetables': 'assets/nutrition_svgs/vegetables.svg',
      'Fruits': 'assets/nutrition_svgs/fruits.svg',
      'Bread': 'assets/nutrition_svgs/bread.svg',
      'Eggs': 'assets/nutrition_svgs/eggs.svg',
      'Energy Bars': 'assets/nutrition_svgs/energy_bar.svg',
      'Potatoes': 'assets/nutrition_svgs/potato.svg',
      'Water': 'assets/nutrition_svgs/water.svg',
    },
    'description': ''
//    'A healthy and filling meal, at times, is worth more than a million dollars.'
  },
  {
    'asset': 'assets/covid-19_response_svg/covid_19.svg',
    'name': 'COVID-19 Response',
    'items': {
      'Face Shields': 'assets/covid-19_response_svg/face_shield.svg',
      'Hand Sanitizers': 'assets/covid-19_response_svg/hand_sanitizer.svg',
      'Latex Gloves': 'assets/covid-19_response_svg/latex_gloves.svg',
      'Masks': 'assets/covid-19_response_svg/mask.svg',
      'Disinfecting Wipes': 'assets/covid-19_response_svg/wipes.svg',
      'Facial Tissues': 'assets/covid-19_response_svg/tissue_paper.svg',
      'Rubbing Alcohol': 'assets/covid-19_response_svg/rubbing_alcohol.svg',
    },
    'description': ''
//    'Everyone deserves protection, especially in these trying times.'
  },
  {
    'asset': 'assets/warmth_svgs/warmth.svg',
    'name': 'Warmth',
    'items': {
      'Blankets': 'assets/warmth_svgs/blanket.svg',
      'Pillows': 'assets/warmth_svgs/pillow.svg',
      'Bed Sheets': 'assets/warmth_svgs/bed_sheets.svg',
      'Sleeping Bag': 'assets/warmth_svgs/sleeping_bag.svg',
      'Sleeping Pad': 'assets/warmth_svgs/sleeping_pad.svg',
    },
    'description': ''
//    'The need for warmth has been engraved into humans since the beginning of life, and has never disappeared'
  },
];

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

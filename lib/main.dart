import 'package:flutter/material.dart';
import 'package:phase1/pages/shelter_confirmation_page.dart';
import 'package:phase1/pages/shelter_sign_up_extended_page.dart';

import 'pages/volunteer_confirmation_page.dart';
import 'pages/volunteer_sign_up_page.dart';
import 'pages/shelter_sign_up_page.dart';
import 'pages/signup_page.dart';
import 'pages/volunteer_confirmation_page.dart';
import 'pages/volunteer_sign_up_page.dart';
import 'pages/welcome_page.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelter Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme : colorScheme,
      ),
      routes: {
        '/': (_) => WelcomePage(),
        '/volunteer_confirmation': (_) => VolunteerConfirmation(),
        '/volunteer_sign_up': (_) => VolunteerSignUp(),
        '/shelter_confirmation': (_) => ShelterConfirmation(),
        '/shelter_sign_up': (_) => ShelterSignUp(),
        '/shelter_sign_up_extended': (_) => ShelterSignUpExtended(),
        '/signup': (_) => SignupPage(),
      },
      initialRoute: '/shelter_confirmation',
    );
  }
}